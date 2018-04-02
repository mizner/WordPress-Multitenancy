#!/bin/bash
# https://easyengine.io/tutorials/nginx/troubleshooting/emerg-bind-failed-98-address-already-in-use/
sudo rm -rf /var/www/html
sudo cp /etc/nginx/snippets/fastcgi-php.conf.dpkg-new /etc/nginx/snippets/fastcgi-php.conf
sudo fuser -k 80/tcp
sudo service nginx start