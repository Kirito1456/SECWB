# users/forms.py

from django import forms
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from django.contrib.auth.models import User
from .models import User
from django.contrib.auth import authenticate
from django.contrib.auth import get_user_model
from django.core.validators import validate_email, RegexValidator
from django.core.exceptions import ValidationError
import re
import magic


class RegistrationForm(forms.ModelForm):
    password = forms.CharField(widget=forms.PasswordInput)
    password_confirm = forms.CharField(widget=forms.PasswordInput, label="Confirm Password")
    profile_photo = forms.ImageField(required=False)

    class Meta:
        model = User
        fields = ['email', 'full_name', 'phone', 'profile_photo', 'password']

    def clean_email(self):
        email = self.cleaned_data.get('email')
        validate_email(email)
        if User.objects.filter(email=email).exists():
            raise forms.ValidationError("Email is already in use.")
        return email

    def clean_phone(self):
        phone = self.cleaned_data.get('phone')
        phone_validator = RegexValidator(regex=r'^(09|\+639)\d{9}$', message="Phone number must be entered in the format: '+639...' or '09...'. 9 succeeding digits only are allowed.")
        phone_validator(phone)
        return phone

    def clean_password(self):
        password = self.cleaned_data.get('password')
        if not re.findall('[A-Z]', password):
            raise ValidationError("Password must contain at least one uppercase letter.")
        if not re.findall('[0-9]', password):
            raise ValidationError("Password must contain at least one number.")
        if not re.findall('[^A-Za-z0-9]', password):
            raise ValidationError("Password must contain at least one special character.")
        if len(password) < 8:
            raise ValidationError("Password must be at least 8 characters long.")
        return password

    def clean_password_confirm(self):
        password = self.cleaned_data.get('password')
        password_confirm = self.cleaned_data.get('password_confirm')
        if password and password_confirm and password != password_confirm:
            raise forms.ValidationError("Passwords do not match.")
        return password_confirm
    
    def clean_profile_photo(self):
        profile_photo = self.cleaned_data.get('profile_photo')
        if profile_photo:
            file_type = magic.from_buffer(profile_photo.read(), mime=True)
            if file_type not in ['image/jpeg', 'image/png', 'image/jpg']:
                raise forms.ValidationError('Invalid file type. Only JPEG and PNG are allowed.')
        return profile_photo

    
