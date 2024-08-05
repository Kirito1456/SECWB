from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import login, authenticate, logout
from django.contrib.auth.decorators import login_required, user_passes_test
from django.core.exceptions import ValidationError
from django.core.validators import validate_email
from .forms import  RegistrationForm, PostForm, CommentForm, UserProfileForm, PostSearchForm, PostFilterForm
from .models import User, Post, Comment
from django.urls import reverse
import logging
from django.http import HttpResponse, HttpResponseForbidden
from django.contrib import messages
from .utils import get_exception_response
from django.conf import settings

logger = logging.getLogger(__name__)

def register(request):
    try:
        if request.method == 'POST':
            form = RegistrationForm(request.POST, request.FILES)
            if form.is_valid():
                user = form.save(commit=False)
                user.set_password(form.cleaned_data['password'])
                user.save()
                logger.info(f"New user registered: {user.email}")
                #login(request, user)
                return redirect('login')
        else:
            form = RegistrationForm()
    except Exception as e:
        logger.error(f"Error during registration: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)
    return render(request, 'register.html', {'form': form})

def user_login(request):

    try:
        # force_error(request)
        if request.method == 'POST':
            email = request.POST.get('email')
            password = request.POST.get('password')
            if email and password:
                user = authenticate(request, email=email, password=password)
                if user is not None:
                    login(request, user)
                    logger.info(f"User {email} logged in.")
                    if user.is_admin:
                        #return redirect(reverse('admin:index'))
                        return redirect('admin_page')
                    else:
                        return redirect('dashboard')
                else:
                    error_message = "Invalid email or password."
                    logger.warning(f"Failed login attempt for {email}.")
            else:
                error_message = "Email and password are required."
        else:
            error_message = None
    except Exception as e:
            logger.error(f"Error during login: {str(e)}", exc_info=True)
            return get_exception_response(request, e, settings.DEBUG)

    return render(request, 'login.html', {'error_message': error_message})

@login_required
def update_profile(request):
    try:
        if request.method == 'POST':
            form = UserProfileForm(request.POST, request.FILES, instance=request.user)
            if form.is_valid():
                form.save()
                logger.info(f"User {request.user.email} updated their profile.")
                return redirect('profile')
        else:
            form = UserProfileForm(instance=request.user)
    except Exception as e:
        logger.error(f"Error updating profile: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)
    return render(request, 'update_profile.html', {'form': form})

@login_required
def dashboard(request):
    try:
        # Ensure user is authenticated before accessing the dashboard
        if not request.user.is_authenticated:
            return redirect('login')  # Redirect to login page if user is not authenticated
        
        posts = Post.objects.filter(is_approved=True)
        search_form = PostSearchForm(request.GET)
        query = request.GET.get('query')
        filter_form = PostFilterForm(request.GET)

        if filter_form.is_valid():
            start_date = filter_form.cleaned_data.get('start_date')
            end_date = filter_form.cleaned_data.get('end_date')

            if start_date and end_date:
                posts = posts.filter(created_at__date__range=[start_date, end_date])
            elif start_date:
                posts = posts.filter(created_at__date__gte=start_date)
            elif end_date:
                posts = posts.filter(created_at__date__lte=end_date)
            

        if query:
            posts = posts.filter(title__icontains=query)
    
    except Exception as e:
        logger.error(f"Error loading dashboard: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)
    
    return render(request, 'dashboard.html', {'posts': posts, 'search_form': search_form,'query': query, 'filter_form': filter_form,})

def user_logout(request):
    try:
        print("Logging out...")
        logout(request)
        logger.info("User logged out.")
        print("User logged out. Redirecting to login.")
    except Exception as e:
        logger.error(f"Error during logout: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)
    return redirect('login')

@login_required
def new_post(request):
    if request.user.is_banned:
        return HttpResponseForbidden("You are banned and cannot create new posts.")
        # messages.error(request, "You are banned and cannot create new posts.")
        # return redirect('dashboard')
    try:

        if request.method == 'POST':
            form = PostForm(request.POST)
            if form.is_valid():
                post = form.save(commit=False)
                post.author = request.user  # Set the author to the currently logged-in user
                post.is_approved = False
                post.save()
                logger.info(f"New post created by {request.user.email}: {post.title}")
                return redirect('dashboard')
        else:
            form = PostForm()

    except Exception as e:
        logger.error(f"Error creating new post: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)
    return render(request, 'new_post.html', {'form': form})

@login_required
def post_detail(request, post_id):
    try:
        post = get_object_or_404(Post, id=post_id, is_approved=True)
        comments = Comment.objects.filter(post=post)
        is_liked = False
        if post.likes.filter(id=request.user.id).exists():
            is_liked = True
        
        if request.user.is_banned:
            # messages.error(request, "You are banned and cannot view this post.")
            # return redirect('dashboard')
            return HttpResponseForbidden("You are banned and cannot view this post.")
        
        if request.method == 'POST':
            form = CommentForm(request.POST)
            if form.is_valid():
                comment = form.save(commit=False)
                comment.user = request.user
                comment.post = post
                comment.save()
                logger.info(f"New comment by {request.user.email} on post {post.title}")
                return redirect('post_detail', post_id=post.id)
        else:
            form = CommentForm()
    except Exception as e:
        logger.error(f"Error loading post detail: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)
    
    return render(request, 'post_detail.html', {'post': post, 'comments': comments, 'form': form, 'is_liked': is_liked,})

@login_required
def edit_post(request, post_id):
    try:
        post = get_object_or_404(Post, id=post_id)

        if request.user.is_banned:
            # messages.error(request, "You are banned and cannot edit this post.")
            # return redirect('dashboard')
            return HttpResponseForbidden("You are banned and cannot edit this post.")

        if request.user != post.author:
            return redirect('dashboard')  # Redirect if the current user is not the author
        

        if request.method == 'POST':
            form = PostForm(request.POST, instance=post)
            if form.is_valid():
                form.save()
                logger.info(f"Post edited by {request.user.email}: {post.title}")
                return redirect('post_detail', post_id=post.id)
        else:
            form = PostForm(instance=post)
    except Exception as e:
        logger.error(f"Error editing post: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)

    return render(request, 'edit_post.html', {'form': form, 'post': post, })

@login_required
def like_post(request, post_id):
    try:
        post = get_object_or_404(Post, id=post_id)

        if request.user.is_banned:
            # messages.error(request, "You are banned and cannot like or unlike posts.")
            # return redirect('post_detail', post_id=post.id)
            return HttpResponseForbidden("You are banned and cannot like or unlike posts.")
        
        if post.likes.filter(id=request.user.id).exists():
            post.likes.remove(request.user)
            logger.info(f"User {request.user.email} unliked the post {post.title}.")
        else:
            post.likes.add(request.user)
            logger.info(f"User {request.user.email} liked the post {post.title}.")
    
    except Exception as e:
        logger.error(f"Error liking post: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)
    
    return redirect('post_detail', post_id=post.id)

@user_passes_test(lambda u: u.is_admin)
def admin_page(request):
    try:
        # Retrieve all users from the database
        users = User.objects.all()
        posts = Post.objects.all()
        
        # Pass the users to the template context
        context = {
            'users': users,
            'posts': posts,
        }

    except Exception as e:
        logger.error(f"Error loading admin page: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)
    
    return render(request, 'admin.html', context)

# @user_passes_test(lambda u: u.is_admin)
# def delete_post(request, post_id):
#     try:
#         post = get_object_or_404(Post, id=post_id)
#         post.delete()
#         logger.info(f"Post deleted by admin {request.user.email}: {post.title}")
    
#     except Exception as e:
#         logger.error(f"Error deleting post: {str(e)}", exc_info=True)
#         return get_exception_response(request, e, settings.DEBUG)
    
#     return redirect('admin_dashboard')

# @user_passes_test(lambda u: u.is_admin)
# def manage_users(request, user_id):
#     if request.method == 'POST':
#         user_id = request.POST.get('user_id')
#         action = request.POST.get('action')
#         user = get_object_or_404(User, pk=user_id)
#         if action == 'deactivate':
#             user.is_active = False
#             user.save()
#             logger.info(f"Admin {request.user.email} deactivated user {user.email}.")
#         elif action == 'delete':
#             user.delete()
#             logger.info(f"Admin {request.user.email} deleted user {user.email}.")
#         return redirect('manage_users')
#     return render(request, 'user_details.html', user_id=user_id)

@user_passes_test(lambda u: u.is_admin)
def view_all_posts(request):
    try:
        posts = Post.objects.all()
    except Exception as e:
        logger.error(f"Error viewing all posts: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)
    return render(request, 'view_all_posts.html', {'posts': posts})

@user_passes_test(lambda u: u.is_admin)
def user_details(request, user_id):
    try:
        user = get_object_or_404(User, id=user_id)
    except Exception as e:
        logger.error(f"Error loading user details: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)
    return render(request, 'user_details.html', {'user': user})

@user_passes_test(lambda u: u.is_admin)
def ban_user(request, user_id):
    try:
        user = get_object_or_404(User, pk=user_id)
        user.is_banned = True
        user.save()
        logger.info(f"Admin {request.user.email} banned user {user.email}.")
    
    except Exception as e:
        logger.error(f"Error banning user: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)
    
    return redirect('user_details', user_id=user_id)

@user_passes_test(lambda u: u.is_admin)
def unban_user(request, user_id):
    try:
        user = get_object_or_404(User, pk=user_id)
        user.is_banned = False
        user.save()
        logger.info(f"Admin {request.user.email} unbanned user {user.email}.")
    except Exception as e:
        logger.error(f"Error unbanning user: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)
    return redirect('user_details', user_id=user_id)

@user_passes_test(lambda u: u.is_admin)
def deactivate_account(request, user_id):
    try:
        user = get_object_or_404(User, id=user_id)
        if user.is_active:
            user.is_active = False
            user.save()
            logger.info(f"Admin {request.user.email} deactivated user {user.email}.")
    except Exception as e:
        logger.error(f"Error deactivating account: {str(e)}", exc_info=True)
        return get_exception_response(request, e)
    return redirect('user_details', user_id=user.id)

def force_error(request):
    raise Exception("This is a test exception to trigger a 500 error.")
# @user_passes_test(lambda u: u.is_admin)
# def edit_post(request, post_id):
#     post = get_object_or_404(Post, id=post_id)
#     if request.method == 'POST':
#         form = PostForm(request.POST, instance=post)
#         if form.is_valid():
#             form.save()
#             logger.info(f"Admin {request.user.email} edited the post {post.title}.")
#             return redirect('admin_dashboard')
#     else:
#         form = PostForm(instance=post)
#     return render(request, 'edit_post.html', {'form': form})

@user_passes_test(lambda u: u.is_admin)
def manage_post(request, post_id, action):
    try:
        post = get_object_or_404(Post, id=post_id)
        
        if action == 'approve':
            post.is_approved = True
            post.save()
            messages.success(request, f"Post '{post.title}' has been approved.")
            logger.info(f"Admin {request.user.email} approved post: {post.title}")
        
        elif action == 'delete':
            post.delete()
            messages.success(request, f"Post '{post.title}' has been deleted.")
            logger.info(f"Admin {request.user.email} deleted post: {post.title}")
        
        else:
            messages.error(request, "Invalid action.")
            return redirect('admin_page')
    
    except Exception as e:
        logger.error(f"Error managing post: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)
    
    return redirect('view_all_posts')