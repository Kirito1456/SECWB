# Generated by Django 4.2.13 on 2024-07-16 19:20

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('website', '0010_user_is_staff'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='is_banned',
            field=models.BooleanField(default=False),
        ),
    ]