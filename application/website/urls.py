from django.urls import path
from . import views

urlpatterns = [
    path('register/', views.register, name='register'),  # Registration URL
    path('', views.user_login, name='login'),  # Login URL
    path('dashboard/', views.dashboard, name='dashboard'),  # Dashboard URL
    path('logout/', views.user_logout, name='logout'),  # Logout URL
    path('admin_page/', views.admin_page, name='admin_page'),  # Logout URL
]
