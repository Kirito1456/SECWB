from django.urls import path
from . import views

urlpatterns = [
    path('register/', views.register, name='register'),  # Registration URL
    path('', views.user_login, name='login'),  # Login URL
    path('dashboard/', views.dashboard, name='dashboard'),  # Dashboard URL
    path('logout/', views.user_logout, name='logout'),  # Logout URL
    path('admin_page/', views.admin_page, name='admin_page'),  # Logout URL
    #path('delete_post/<int:post_id>/', views.delete_post, name='delete_post'),
    # path('manage_users/', views.manage_users, name='manage_users'),
    path('view_all_posts/', views.view_all_posts, name='view_all_posts'),
    path('post/<int:post_id>/edit/', views.edit_post, name='edit_post'),
    path('post/<int:post_id>/like/', views.like_post, name='like_post'),
    path('post/<int:post_id>/', views.post_detail, name='post_detail'),
    path('profile/', views.update_profile, name='profile'),
    path('post/new/', views.new_post, name='new_post'),
    path('user_details/<int:user_id>/', views.user_details, name='user_details'),
    path('user_details/<int:user_id>/ban/', views.ban_user, name='ban_user'),
    path('user_details/<int:user_id>/unban/', views.unban_user, name='unban_user'),
    path('deactivate_account/<int:user_id>/unban/', views.deactivate_account, name='deactivate_account'),
    path('view_all_posts/manage-post/<int:post_id>/<str:action>/', views.manage_post, name='manage_post'),
]
