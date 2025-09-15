# Baby Tools Shop – Dockerized Django Project

## DESCRIPTION
This is a small Django E-Commerce projekt (Baby Tools Shop), that has been containerized as a part of the **DevSecOps education**.
The container uses **Gunicorn** as the  WSGI server and can optimally be comined with **Nginx** as reverse proxy.
The goal is to achieve the first deployment on a V-Server using Docker. 🐳

## TABLE OF CONTENTS
1. [Prerequisites](#prerequisites)  
2. [Quickstart](#quickstart)  
3. [Usage](#usage)  
4. [Additional Notes](#additional-notes)


## PREREQUISITES
- **Docker** v. 27.5.1
- **Git**
- Optional: **Nginx** installed on the Server 

## QUICKSTART
Clone repository:
```bash
git clone https://github.com/<DEIN-GITHUB-USER>/<DEIN-REPO>.git
cd baby-tools-shop
```
Build Docker image:
```bash
docker build --no-cache -t babyshop_app  -f Dockerfile .
```
Start container:
```bash
docker run -d --name babyshop --restart unless-stopped \
  -p 127.0.0.1:8000:8000 babyshop_app
```
The app is now reachable at http://127.0.0.1:8000.

## USAGE

### Relevant Files

### ::::Dockerfile::::
Defines how the image ist built.
```docker
FROM python:3.9-alpine

WORKDIR /app

COPY . .

RUN python -m pip install -r requirements.txt

RUN chmod +x entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["./entrypoint.sh"]
```
**Explanation:**
- Use a small Python-Alpine image
- Sets working directory to /app
- Copies project files into the image
- Install python depencies from requirements.txt
- Makes entrypoint.sh executable.
- Automatically starts with entrypoint.sh
 

### ::::entrypoint.sh::::
Startup script that runs when the container is launched.
```bash
#!/bin/sh
set -e

echo "Running Django setup..."

python manage.py collectstatic --noinput
python manage.py makemigrations
python manage.py migrate

echo "Starting Gunicorn..."
exec gunicorn babyshop.wsgi:application --bind 0.0.0.0:8000
```
**Explanation:**
- `#!/bin/sh` -> tells the system to use the shell to execute this script
- `set -e` -> stop the container if any command fails
- `collectstatic` -> collects all static files into one folder (used by Whitenoise)
- `makemigrations & migrate` -> applies database migrations automatically
- Starts Gunicorn as the WSGI server
 

### Container Commands

Build Docker image:
```bash
docker build --no-cache -t babyshop_app  -f Dockerfile .
```

Start container:
```bash
docker run -d --name babyshop --restart unless-stopped \
  -p 127.0.0.1:8000:8000 babyshop_app
```

Show all containers
```bash
docker ps -a
```
Show running containers
```bash
docker ps
```

Show all images
```bash
docker image ls
```

Show logs:
```bash
docker logs -f babyshop
```

Stop container:
```bash
docker stop babyshop
```

Delete container:
```bash
docker rm -f babyshop
```

Delete image:
```bash
docker rmi babyshop_app
```

## ADDITIONAL NOTES

- Gunicorn acts as the WSGI server for Django
- Using `docker run -p 127.0.0.1:8000:8000` makes the service available only locally
- For external access, Nginx is recommended as a reverse proxy
- Whitenoise is enabled to serve static files directly via Django/Gunicorn




