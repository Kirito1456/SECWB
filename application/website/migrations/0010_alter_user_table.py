# Generated by Django 4.2.13 on 2024-06-07 18:04

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('website', '0009_user_delete_userprofile'),
    ]

    operations = [
        migrations.AlterModelTable(
            name='user',
            table='users',
        ),
    ]
