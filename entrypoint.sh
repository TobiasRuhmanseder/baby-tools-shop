#!/bin/sh

set -e
echo "Running Django setup..."

cd /app/babyshop_app
python manage.py collectstatic --noinput
python manage.py makemigrations
python manage.py migrate

echo "Starting Gunicorn..."
exec gunicorn babyshop.wsgi:application --bind 0.0.0.0:8000