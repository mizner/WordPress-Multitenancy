#!/bin/bash
# /*=====================================
# =            INSTALL NGINX            =
# =====================================*/
# Install Nginx
sudo apt-get -y install nginx
sudo systemctl enable nginx

# Remove "html" and add public
mv -f /var/www/html /var/www/public

# Make sure your web server knows you did this...
MY_WEB_CONFIG='server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/public;
    index index.php index.html index.htm index.nginx-debian.html;

    server_name _;

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php7.2-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}'
echo "$MY_WEB_CONFIG" | sudo tee /etc/nginx/sites-available/default

# Restart NGNIX
sudo systemctl restart nginx