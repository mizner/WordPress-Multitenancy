#!/bin/bash

# /*===================================
# =            PHP MODULES            =
# ===================================*/

# Base Stuff
sudo apt-get -y install php7.2-common
sudo apt-get -y install php7.2-dev

# Common Useful Stuff (some of these are probably already installed)
sudo apt-get -y install php7.2-bcmath
sudo apt-get -y install php7.2-bz2
sudo apt-get -y install php7.2-cgi
sudo apt-get -y install php7.2-cli
sudo apt-get -y install php7.2-gd
sudo apt-get -y install php7.2-imap
sudo apt-get -y install php7.2-intl
sudo apt-get -y install php7.2-json
sudo apt-get -y install php7.2-mbstring
sudo apt-get -y install php7.2-odbc
sudo apt-get -y install php-pear
sudo apt-get -y install php7.2-pspell
sudo apt-get -y install php7.2-tidy
sudo apt-get -y install php7.2-xmlrpc
sudo apt-get -y install php7.2-zip

# Enchant
sudo apt-get -y install libenchant-dev
sudo apt-get -y install php7.2-enchant

# LDAP
sudo apt-get -y install ldap-utils
sudo apt-get -y install php7.2-ldap

# CURL
sudo apt-get -y install curl
sudo apt-get -y install php7.2-curl

# IMAGE MAGIC
sudo apt-get -y install imagemagick
sudo apt-get -y install php7.2-imagick

# X-Debug
sudo apt-get install php-xdebug # http://www.dieuwe.com/blog/xdebug-ubuntu-1604-php7 (x-debug instructions)

# /*==============================
# =            WP-CLI            =
# ==============================*/
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
sudo chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

# /*================================
# =            COMPOSER            =
# ================================*/
EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig)
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")
php composer-setup.php --quiet
rm composer-setup.php
sudo mv composer.phar /usr/local/bin/composer
sudo chmod 755 /usr/local/bin/composer