#!/bin/bash

# /*===================================
# =            INSTALL PHP            =
# ===================================*/
sudo apt-get -y install  php7.2

# --------------------------
# Make PHP and NGINX friends
# --------------------------
# FPM STUFF
sudo apt-get -y install php7.2-fpm
sudo systemctl enable php7.2-fpm
sudo systemctl start php7.2-fpm

# Fix path FPM setting
echo 'cgi.fix_pathinfo = 0' | sudo tee -a /etc/php/7.2/fpm/conf.d/user.ini
sudo systemctl restart php7.2-fpm

sudo systemctl restart nginx