# Generated by Django 4.2.13 on 2024-06-08 08:28

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('admin', '0013_alter_logentry_user'),
        ('website', '0005_rename_user_customuser'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='CustomUser',
            new_name='User',
        ),
    ]
