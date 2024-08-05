# users/forms.py

from django import forms
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from django.contrib.auth.models import User
from .models import User, Post, Comment
from django.contrib.auth import authenticate
from django.contrib.auth import get_user_model
from django.core.validators import validate_email, RegexValidator
from django.core.exceptions import ValidationError
import re
import magic
from django.utils.html import strip_tags


class RegistrationForm(forms.ModelForm):
    password = forms.CharField(widget=forms.PasswordInput)
    password_confirm = forms.CharField(widget=forms.PasswordInput, label="Confirm Password")
    profile_photo = forms.ImageField(required=False)

    class Meta:
        model = User
        fields = ['email', 'full_name', 'username', 'phone', 'profile_photo', 'password']

    def clean_email(self):
        email = self.cleaned_data.get('email')
        validate_email(email)
        if User.objects.filter(email=email).exists():
            raise forms.ValidationError("Email is already in use.")
        return email
    
    def clean_username(self):
        username = self.cleaned_data.get('username')
        if not re.match(r'^[a-zA-Z0-9_]+$', username):
            raise ValidationError('Username can only contain letters, numbers, and underscores.')
        return username

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
    
class PostForm(forms.ModelForm):
    class Meta:
        model = Post
        fields = ['title', 'content']

    def clean_title(self):
        title = self.cleaned_data['title']
        # Example: Validate title length
        if len(title) < 5:
            raise ValidationError('Title must be at least 5 characters long.')
        return title

    def clean_content(self):
        content = self.cleaned_data['content']
        # Input Sanitization (strip_tags): The strip_tags function from django.utils.html is used to sanitize HTML 
        # input in content fields (content in PostForm and CommentForm). This helps prevent Cross-Site Scripting (XSS) attacks
        # by removing HTML tags.
        sanitized_content = strip_tags(content)
        return sanitized_content

class CommentForm(forms.ModelForm):
    class Meta:
        model = Comment
        fields = ['content']

    def clean_content(self):
        content = self.cleaned_data['content']
        sanitized_content = strip_tags(content)
        return sanitized_content


class UserProfileForm(forms.ModelForm):
    class Meta:
        model = User
        fields = ['full_name', 'phone', 'profile_photo', 'username']

    
    def clean_email(self):
        email = self.cleaned_data.get('email')
        validate_email(email)
        if User.objects.filter(email=email).exists():
            raise forms.ValidationError("Email is already in use.")
        return email
    
    def clean_username(self):
        username = self.cleaned_data.get('username')
        if not re.match(r'^[a-zA-Z0-9_]+$', username):
            raise ValidationError('Username can only contain letters, numbers, and underscores.')
        return username

    def clean_phone(self):
        phone = self.cleaned_data.get('phone')
        phone_validator = RegexValidator(regex=r'^(09|\+639)\d{9}$', message="Phone number must be entered in the format: '+639...' or '09...'. 9 succeeding digits only are allowed.")
        phone_validator(phone)
        return phone
    
    def clean_profile_photo(self):
        profile_photo = self.cleaned_data.get('profile_photo')
        if profile_photo:
            file_type = magic.from_buffer(profile_photo.read(), mime=True)
            if file_type not in ['image/jpeg', 'image/png', 'image/jpg']:
                raise forms.ValidationError('Invalid file type. Only JPEG and PNG are allowed.')
        return profile_photo

class PostSearchForm(forms.Form):
    query = forms.CharField(label='Search Posts', max_length=100, required=False)

class PostFilterForm(forms.Form):
    date_format = '%Y-%m-%d'  # Define your desired date format here

    start_date = forms.DateField(
        label='Start Date',
        required=False,
        input_formats=[date_format],
        widget=forms.DateInput(attrs={'placeholder': 'YYYY-MM-DD'}),
        error_messages={'invalid': 'Enter a valid date in YYYY-MM-DD format.'}
    )
    end_date = forms.DateField(
        label='End Date',
        required=False,
        input_formats=[date_format],
        widget=forms.DateInput(attrs={'placeholder': 'YYYY-MM-DD'}),
        error_messages={'invalid': 'Enter a valid date in YYYY-MM-DD format.'}
    )

    def clean(self):
        cleaned_data = super().clean()
        start_date = cleaned_data.get("start_date")
        end_date = cleaned_data.get("end_date")

        if start_date and end_date:
            if start_date > end_date:
                raise ValidationError("End Date must be after or equal to Start Date.")

        return cleaned_data
    
