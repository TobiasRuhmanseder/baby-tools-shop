# Baby Tools Shop – Dockerized Django Project

## DESCRIPTION
This is a small Django E-Commerce projekt (Baby Tools Shop), that has been containerized as a part of the **DevSecOps education**.
Currently, the container uses Django’s built-in `runserver` for simplicity (especially to serve media files directly).  
In a production-ready setup, this would be replaced by **Gunicorn** as the WSGI server, ideally combined with **Nginx** as a reverse proxy.  
The goal is to achieve the first deployment on a V-Server using Docker. 🐳

## TABLE OF CONTENTS
1. [Prerequisites](#prerequisites)  
2. [Quickstart](#quickstart)  
3. [Usage](#usage)  
4. [Additional Notes](#additional-notes)


## PREREQUISITES
- **Docker** v. 27.5.1
- **Git**

## QUICKSTART
Clone repository:
```bash
git clone https://github.com/TobiasRuhmanseder/baby-tools-shop.git
cd baby-tools-shop
```
Build Docker image:
```bash
docker build --no-cache -t babyshop_app  -f Dockerfile .
```
Start container:
```bash
docker run -d --name babyshop --restart unless-stopped \
  -p 8025:8000 babyshop_app
```
The app is now reachable at `http://your_server_address:8025`.

## USAGE

### Relevant Files

#### Dockerfile
The Dockerfile builds the container image. It uses Python 3.9-alpine as a base, 
copies all files into `/app`, installs dependencies from `requirements.txt`, 
and sets `entrypoint.sh` as the startup script.  

👉 [View Dockerfile](./Dockerfile)  

#### entrypoint.sh
The entrypoint script runs database migrations, collects static files, check if an superuser already exist, if not create one, and 
starts Django’s built-in development server (`runserver`).  

👉 [View entrypoint.sh](./entrypoint.sh)

### Container Commands

Build Docker image:
```bash
docker build --no-cache -t babyshop_app  -f Dockerfile .
```

Start container:
```bash
docker run -d --name babyshop --restart unless-stopped \
  -p 8025:8000 babyshop_app
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
- Using `docker run -p 8025:8000` makes the service available on port 8025 of the host
- For external access, Nginx is recommended as a reverse proxy
- Whitenoise is enabled to serve static files directly via Django/Gunicorn




