from django.shortcuts import render, redirect
from django.contrib.auth import login, authenticate
from django.contrib.auth.decorators import login_required
from django.core.exceptions import ValidationError
from django.core.validators import validate_email
from .forms import  UserRegistrationForm
#from axes.backends import AxesBackend
from .models import User

def register(request):
    if request.method == 'POST':
        form = UserRegistrationForm(request.POST, request.FILES)
        if form.is_valid():
            user = form.save(commit=False)
            print(form.cleaned_data['email'])
            print(form.cleaned_data['password'])
            print(user)
            user.set_password(form.cleaned_data['password'])
            user.save()
            #user.backend = 'django.contrib.auth.backends.ModelBackend'
            login(request, user)
            print(user.password)
            print(user.email)
            return redirect('dashboard')
    else:
        form = UserRegistrationForm()
    return render(request, 'register.html', {'form': form})

def user_login(request):
    if request.method == 'POST':
        email = request.POST.get('email')
        password = request.POST.get('password')
        
        if email and password:
            #axes_backend = AxesBackend()
            print(email)
            print(password)
            user = authenticate(request=request, email=email, password=password)
            #user.backend = 'django.contrib.auth.backends.ModelBackend'
            print(user)
            if user is None:
                login(request, user)
                return redirect('dashboard')  # Redirect to dashboard upon successful login
            else:
                error_message = "Invalid email or password."
        else:
            error_message = "Email and password are required."
    else:
        error_message = None

    return render(request, 'login.html', {'error_message': error_message})

@login_required
def admin(request):
    if not request.user.is_admin:
        return redirect('login')
    users = User.objects.all()
    return render(request, 'admin.html', {'users': users})


def dashboard(request):
    return render(request, 'dashboard.html')
