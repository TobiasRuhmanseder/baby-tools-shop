# This is the base image of our application image
FROM python:3.9-alpine

# This is a special directory variable, that can be used to encapsulate 
# all applicaiton/container specific files/assets into a separate folder on the system
WORKDIR /app

# Copy relevant files and assets from the Host during the build process
COPY . .

# Install all depencies for the applications that lives in the container
RUN python -m pip install -r requirements.txt

# Make entrypoint script executable
RUN chmod +x entrypoint.sh

EXPOSE 8000

# This ist the command that will be executed on container lauch
ENTRYPOINT ["./entrypoint.sh"]

