from django.shortcuts import render, redirect
from django.contrib.auth import login, authenticate, logout
from django.contrib.auth.decorators import login_required
from django.core.exceptions import ValidationError
from django.core.validators import validate_email
from .forms import  RegistrationForm
from .models import User

def register(request):
    if request.method == 'POST':
        form = RegistrationForm(request.POST, request.FILES)
        if form.is_valid():
            user = form.save(commit=False)
            user.set_password(form.cleaned_data['password'])
            user.save()
            #login(request, user)
            return redirect('login')
    else:
        form = RegistrationForm()
    return render(request, 'register.html', {'form': form})

def user_login(request):
    if request.method == 'POST':
        email = request.POST.get('email')
        password = request.POST.get('password')
        print(email)
        print(password)
        if email and password:
            user = authenticate(request, email=email, password=password)
            print(user)
            if user is not None:
                login(request, user)
                return redirect('dashboard')
            else:
                error_message = "Invalid email or password."
        else:
            error_message = "Email and password are required."
    else:
        error_message = None

    return render(request, 'login.html', {'error_message': error_message})

def dashboard(request):
    # Ensure user is authenticated before accessing the dashboard
    if not request.user.is_authenticated:
        return redirect('login')  # Redirect to login page if user is not authenticated
    return render(request, 'dashboard.html')

def user_logout(request):
    logout(request)
    return redirect('login')
