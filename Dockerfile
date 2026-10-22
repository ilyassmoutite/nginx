# Use the official lightweight NGINX Alpine image
FROM nginxinc/nginx-unprivileged:alpine

# (Optional) Remove the default NGINX website configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy your custom NGINX configuration file into the container
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy your local static website files to the NGINX HTML directory
COPY ./html /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start NGINX in the foreground (keeps the container running)
CMD ["nginx", "-g", "daemon off;"]