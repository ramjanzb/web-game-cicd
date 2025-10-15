# Use the official stable NGINX image as base
FROM nginx:alpine

# Copy project files into NGINX’s web root
COPY . /usr/share/nginx/html

# Expose default HTTP port
EXPOSE 80

# Start NGINX in foreground (required for Docker)
CMD ["nginx", "-g", "daemon off;"]

