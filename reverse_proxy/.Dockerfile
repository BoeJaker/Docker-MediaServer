FROM nginx:latest

# Copy Nginx configuration file
COPY /reverse_proxy/nginx.conf /etc/nginx/nginx.conf

# Copy SSL certificate and key (if using HTTPS)
# COPY ssl.crt /etc/nginx/ssl.crt
# COPY ssl.key /etc/nginx/ssl.key

# Copy the default Nginx landing page
# COPY index.html /usr/share/nginx/html/index.html
