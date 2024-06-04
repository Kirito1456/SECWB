from django.urls import path
from website import views

urlpatterns = [
    path('', views.user_login, name='login'),
    path('register/', views.register, name='register'),
    path('admin/', views.admin, name='admin'),
    path('dashboard/', views.dashboard, name='dashboard'),
]