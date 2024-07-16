from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager

class UserManager(BaseUserManager):
    def create_user(self, email, full_name, phone, username, password=None, profile_photo=None):
        if not email:
            raise ValueError("Users must have an email address")
        if not full_name:
            raise ValueError("Users must have a full name")
        if not username:
            raise ValueError("Users must have a username")
        if not phone:
            raise ValueError("Users must have a phone number")
        if not password:
            raise ValueError("Users must have a password")

        user = self.model(
            email=self.normalize_email(email),
            full_name=full_name,
            phone=phone,
            username=username,
            profile_photo=profile_photo,
            password=password
        )
        user.save(using=self._db)
        return user

    def create_superuser(self, email, full_name, phone, username, password=None, profile_photo=None):
        user = self.create_user(email, full_name, phone, username, password, profile_photo)
        user.is_admin = True
        user.is_staff = True
        user.is_active = True
        user.set_password(password)
        user.save(using=self._db)
        return user

class User(AbstractBaseUser):
    id = models.AutoField(primary_key=True)
    username = models.CharField(max_length=255, unique=True, blank=True, null=True)
    full_name = models.CharField(max_length=255)
    email = models.EmailField(max_length=255, unique=True)
    phone = models.CharField(max_length=20)
    profile_photo = models.ImageField(upload_to='profile_photos/', blank=True, null=True)
    password = models.CharField(max_length=255)
    is_admin = models.BooleanField(default=False)
    is_staff = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)
    is_banned = models.BooleanField(default=False)

    objects = UserManager()

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['full_name', 'phone', 'username']

    def __str__(self):
        return self.email

    def has_perm(self, perm, obj=None):
        return True

    def has_module_perms(self, app_label):
        return True
    
    @property
    def staff_status(self):
        return self.is_admin

    class Meta:
        db_table = 'users'

class Post(models.Model):
    author = models.ForeignKey(User, on_delete=models.CASCADE)
    title = models.CharField(max_length=255)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    likes = models.ManyToManyField(User, related_name='liked_posts', default=0)

    def __str__(self):
        return self.title
    def total_likes(self):
        return self.likes.count()

class Comment(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    post = models.ForeignKey(Post, on_delete=models.CASCADE)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.content

