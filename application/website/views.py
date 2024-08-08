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
from django.utils.decorators import decorator_from_middleware
from django.views.decorators.cache import cache_control

auth_logger = logging.getLogger('auth_logger')
transaction_logger = logging.getLogger('transaction_logger')
admin_logger = logging.getLogger('admin_logger')

def register(request):
    try:
        if request.method == 'POST':
            form = RegistrationForm(request.POST, request.FILES)
            if form.is_valid():
                user = form.save(commit=False)
                user.set_password(form.cleaned_data['password'])
                user.save()
                auth_logger.info(f"New user registered: {user.email}")
                return redirect('login')
        else:
            form = RegistrationForm()
    except Exception as e:
        auth_logger.error(f"Error during registration: {str(e)}", exc_info=True)
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
                    auth_logger.info(f"User {email} logged in.")
                    if user.is_admin:
                        return redirect('admin_page')
                    else:
                        return redirect('dashboard')
                else:
                    error_message = "Invalid email or password."
                    auth_logger.warning(f"Failed login attempt for {email}.")
            else:
                error_message = "Email and password are required."
        else:
            error_message = None
    except Exception as e:
            auth_logger.error(f"Error during login: {str(e)}", exc_info=True)
            return get_exception_response(request, e, settings.DEBUG)

    return render(request, 'login.html', {'error_message': error_message})

@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def update_profile(request):
    try:
        if request.method == 'POST':
            form = UserProfileForm(request.POST, request.FILES, instance=request.user)
            if form.is_valid():
                form.save()
                auth_logger.info(f"User {request.user.email} updated their profile.")
                return redirect('profile')
        else:
            form = UserProfileForm(instance=request.user)
    except Exception as e:
        auth_logger.error(f"Error updating profile: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)
    return render(request, 'update_profile.html', {'form': form})

@cache_control(no_cache=True, must_revalidate=True, no_store=True)
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
        transaction_logger.error(f"Error loading dashboard: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)
    
    return render(request, 'dashboard.html', {'posts': posts, 'search_form': search_form,'query': query, 'filter_form': filter_form,})

def user_logout(request):
    try:
        auth_logger.info(f"User {request.user.email if request.user.is_authenticated else 'Anonymous'} logged out.")
        request.session.flush()
        logout(request)
        
        # Prevent going back to the previous page by setting cache-control headers
        response = redirect('login')
        response['Cache-Control'] = 'no-cache, no-store, must-revalidate'
        response['Pragma'] = 'no-cache'
        response['Expires'] = '0'

        return response
    
    except Exception as e:
        auth_logger.error(f"Error during logout: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)

@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def new_post(request):
    if request.user.is_banned:
        auth_logger.warning(f"Banned user {request.user.email} attempted to create a new post.")
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
                transaction_logger.info(f"New post created by {request.user.email}: {post.title}")
                return redirect('dashboard')
        else:
            form = PostForm()

    except Exception as e:
        transaction_logger.error(f"Error creating new post: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)
    return render(request, 'new_post.html', {'form': form})

@cache_control(no_cache=True, must_revalidate=True, no_store=True)
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
            auth_logger.warning(f"Banned user {request.user.email} attempted to view this post.")
            return HttpResponseForbidden("You are banned and cannot view this post.")
        
        if request.method == 'POST':
            form = CommentForm(request.POST)
            if form.is_valid():
                comment = form.save(commit=False)
                comment.user = request.user
                comment.post = post
                comment.save()
                transaction_logger.info(f"New comment by {request.user.email} on post {post.title}")
                return redirect('post_detail', post_id=post.id)
        else:
            form = CommentForm()
    except Exception as e:
        transaction_logger.error(f"Error loading post detail: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)
    
    return render(request, 'post_detail.html', {'post': post, 'comments': comments, 'form': form, 'is_liked': is_liked,})

@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def edit_post(request, post_id):
    try:
        post = get_object_or_404(Post, id=post_id)

        if request.user.is_banned:
            # messages.error(request, "You are banned and cannot edit this post.")
            # return redirect('dashboard')
            auth_logger.warning(f"Banned user {request.user.email} attempted to edit this post.")
            return HttpResponseForbidden("You are banned and cannot edit this post.")

        if request.user != post.author:
            return redirect('dashboard')  # Redirect if the current user is not the author
        

        if request.method == 'POST':
            form = PostForm(request.POST, instance=post)
            if form.is_valid():
                form.save()
                transaction_logger.info(f"Post edited by {request.user.email}: {post.title}")
                return redirect('post_detail', post_id=post.id)
        else:
            form = PostForm(instance=post)
    except Exception as e:
        transaction_logger.error(f"Error editing post: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)

    return render(request, 'edit_post.html', {'form': form, 'post': post, })

@login_required
def like_post(request, post_id):
    try:
        post = get_object_or_404(Post, id=post_id)

        if request.user.is_banned:
            # messages.error(request, "You are banned and cannot like or unlike posts.")
            # return redirect('post_detail', post_id=post.id)
            auth_logger.warning(f"Banned user {request.user.email} attempted to like or unlike posts.")
            return HttpResponseForbidden("You are banned and cannot like or unlike posts.")
        
        if post.likes.filter(id=request.user.id).exists():
            post.likes.remove(request.user)
            transaction_logger.info(f"User {request.user.email} unliked the post {post.title}.")
        else:
            post.likes.add(request.user)
            transaction_logger.info(f"User {request.user.email} liked the post {post.title}.")
    
    except Exception as e:
        transaction_logger.error(f"Error liking post: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)
    
    return redirect('post_detail', post_id=post.id)

@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
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
        admin_logger.error(f"Error loading admin page: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)
    
    return render(request, 'admin.html', context)

@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
@user_passes_test(lambda u: u.is_admin)
def view_all_posts(request):
    try:
        posts = Post.objects.all()
    except Exception as e:
        admin_logger.error(f"Error viewing all posts: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)
    return render(request, 'view_all_posts.html', {'posts': posts})

@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
@user_passes_test(lambda u: u.is_admin)
def user_details(request, user_id):
    try:
        user = get_object_or_404(User, id=user_id)
    except Exception as e:
        admin_logger.error(f"Error loading user details: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)
    return render(request, 'user_details.html', {'user': user})

@user_passes_test(lambda u: u.is_admin)
def ban_user(request, user_id):
    try:
        user = get_object_or_404(User, pk=user_id)
        user.is_banned = True
        user.save()
        admin_logger.info(f"Admin {request.user.email} banned user {user.email}.")
    
    except Exception as e:
        admin_logger.error(f"Error banning user: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)
    
    return redirect('user_details', user_id=user_id)

@user_passes_test(lambda u: u.is_admin)
def unban_user(request, user_id):
    try:
        user = get_object_or_404(User, pk=user_id)
        user.is_banned = False
        user.save()
        admin_logger.info(f"Admin {request.user.email} unbanned user {user.email}.")
    except Exception as e:
        admin_logger.error(f"Error unbanning user: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)
    return redirect('user_details', user_id=user_id)

@user_passes_test(lambda u: u.is_admin)
def deactivate_account(request, user_id):
    try:
        user = get_object_or_404(User, id=user_id)
        if user.is_active:
            user.is_active = False
            user.save()
            admin_logger.info(f"Admin {request.user.email} deactivated user {user.email}.")
    except Exception as e:
        admin_logger.error(f"Error deactivating account: {str(e)}", exc_info=True)
        return get_exception_response(request, e)
    return redirect('user_details', user_id=user.id)

def force_error(request):
    raise Exception("This is a test exception to trigger a 500 error.")

@user_passes_test(lambda u: u.is_admin)
def manage_post(request, post_id, action):
    try:
        post = get_object_or_404(Post, id=post_id)
        
        if action == 'approve':
            post.is_approved = True
            post.save()
            messages.success(request, f"Post '{post.title}' has been approved.")
            admin_logger.info(f"Admin {request.user.email} approved post: {post.title}")
        
        elif action == 'delete':
            post.delete()
            messages.success(request, f"Post '{post.title}' has been deleted.")
            admin_logger.info(f"Admin {request.user.email} deleted post: {post.title}")
        
        else:
            messages.error(request, "Invalid action.")
            return redirect('admin_page')
    
    except Exception as e:
        admin_logger.error(f"Error managing post: {str(e)}", exc_info=True)
        return get_exception_response(request, e, settings.DEBUG)
    
    return redirect('view_all_posts')