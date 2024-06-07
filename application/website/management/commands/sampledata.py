from django.core.management.base import BaseCommand
from website.models import User

class Command(BaseCommand):
    help = 'Create sample user data'

    def handle(self, *args, **kwargs):
        if not User.objects.filter(email='user@gmail.com').exists():
            User.objects.create_user(
                email='user@gmail.com',
                full_name='David Smith',
                phone='1234567890',
                password='pasSword123!'
            )
            self.stdout.write(self.style.SUCCESS('Sample user created'))

