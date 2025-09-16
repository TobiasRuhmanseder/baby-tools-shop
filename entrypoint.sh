#!/bin/sh

set -e
echo "Running Django setup..."

cd /app/babyshop_app

python manage.py collectstatic --noinput
python manage.py makemigrations
python manage.py migrate

#check if a superuser already exist - if not - create one
python manage.py shell <<EOF
import os
from django.contrib.auth import get_user_model

User = get_user_model()
username = os.environ.get('DJANGO_SUPERUSER_USERNAME', 'admin')
email = os.environ.get('DJANGO_SUPERUSER_EMAIL', 'admin@example.com')
password = os.environ.get('DJANGO_SUPERUSER_PASSWORD', 'adminpassword')

if not User.objects.filter(username=username).exists():
    print(f"Creating superuser '{username}'...")
    # Korrekter Aufruf: username hier übergeben
    User.objects.create_superuser(username=username, email=email, password=password)
    print(f"Superuser '{username}' created.")
else:
    print(f"Superuser '{username}' already exists.")
EOF

echo "Starting Gunicorn..."
exec python manage.py runserver 0.0.0.0:8000