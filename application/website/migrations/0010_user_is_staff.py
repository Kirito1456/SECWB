# Generated by Django 4.2.13 on 2024-07-16 15:40

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('website', '0009_user_is_active_user_username_alter_post_likes'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='is_staff',
            field=models.BooleanField(default=False),
        ),
    ]
