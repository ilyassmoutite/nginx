# # Use the official lightweight NGINX Alpine image docker.io/nginx/nginx-unprivileged:alpine3.24-perl
# FROM nginx 


# # (Optional) Remove the default NGINX website configuration
# RUN rm /etc/nginx/conf.d/default.conf

# # Copy your custom NGINX configuration file into the container
# # COPY nginx.conf /etc/nginx/conf.d/default.conf

# # Copy your local static website files to the NGINX HTML directory
# COPY ./html /usr/share/nginx/html

# # Expose port 80 to the outside world
# EXPOSE 8080

# # Start NGINX in the foreground (keeps the container running)
# CMD ["nginx", "-g", "daemon off;"]
FROM ubuntu:22.04

# Avoid prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install NGINX and clean up packages to reduce image size
RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

RUN chown -R :0  /var/log/nginx /var/lib/nginx /etc/nginx && \
    chmod -R g+w  /var/log/nginx /var/lib/nginx /etc/nginx    
# Copy configuration and static content
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./html /var/www/html

# Inform Docker that the container listens on port 80
EXPOSE 80

# Start NGINX in the foreground so the Docker container remains running
CMD ["nginx", "-g", "daemon off;"]