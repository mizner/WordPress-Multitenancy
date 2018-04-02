#!/bin/bash

# https://raw.githubusercontent.com/scotch-io/scotch-box-build-scripts/master/install.sh

# /*=================================
# =            VARIABLES            =
# =================================*/
WELCOME_MESSAGE='
🚀 🚀 🚀 🚀 🚀 🚀 🚀 🚀 🚀 🚀 🚀 🚀
   _____                   _
  / ____|                 | |
 | (___  _ _ __ ___  _ __ | | ___
  \___ \| |  _   _ \|  _ \| |/ _ \
  ____) | | | | | | | |_) | |  __/
 |_____/|_|_| |_| |_| .__/|_|\___|
  _                  _         _
 | |                | |       | |
 | |     __ _ _   _ |_|_   ___| |__
 | |    / _  | | | |  _ \ / __|  _ \
 | |___| (_| | |_| | | | | (__| | | |
 |______\__,_|\__,_|_| |_|\___|_| |_|

 🚀 🚀 🚀 🚀 🚀 🚀 🚀 🚀 🚀 🚀 🚀 🚀
'
INSTALL_CORE_ADDONS=1
INSTALL_PHP_ADDONS=1
INSTALL_MYSQL=1
INSTALL_REDIS=0

# /*=================================
# =            FUNCTIONS            =
# =================================*/
reboot_webserver_helper() {
    sudo systemctl restart php7.2-fpm
    sudo systemctl restart nginx

    echo 'Rebooting your webserver'
}

# /*=========================================
# =            CORE / BASE STUFF            =
# =========================================*/
sudo apt-get update

# The following is "sudo apt-get -y upgrade" without any prompts
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade

sudo apt-get -y upgrade
sudo apt-get install -y build-essential
sudo apt-get install -y tcl
sudo apt-get install -y software-properties-common

if [ $INSTALL_CORE_ADDONS == 1 ]; then
    # sudo apt-get -y install vim
    sudo apt-get -y install git-core

    # Zsh
    sudo apt-get -y install zsh
    wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh 
    sudo chsh -s /bin/zsh vagrant

    # JQ JSON tools
    sudo apt-get -y install jq # JSON Tools https://stedolan.github.io/jq/download/
fi

# Weird Vagrant issue fix
sudo apt-get install -y ifupdown

# /*=====================================
# =            INSTALL NGINX            =
# =====================================*/
# Install Nginx
sudo add-apt-repository -y ppa:ondrej/nginx-mainline # Super Latest Version
sudo apt-get update
sudo apt-get -y install nginx
sudo systemctl enable nginx

# Remove "html" and add public
sudo mv /var/www/html /var/www/public

sudo systemctl restart nginx

# /*===================================
# =            INSTALL PHP            =
# ===================================*/

# Install PHP
sudo add-apt-repository -y ppa:ondrej/php # Super Latest Version (currently 7.2)
sudo apt-get update
sudo apt-get install -y php7.2

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

# /*===================================
# =            PHP MODULES            =
# ===================================*/

if [ $INSTALL_PHP_ADDONS == 1 ]; then

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

    # sudo apt-get install php-xdebug # http://www.dieuwe.com/blog/xdebug-ubuntu-1604-php7 (x-debug instructions)
fi

# /*===========================================
# =            CUSTOM PHP SETTINGS            =
# ===========================================*/
PHP_USER_INI_PATH=/etc/php/7.2/fpm/conf.d/user.ini # NGNIX w FPM Only

echo 'display_startup_errors = On' | sudo tee -a $PHP_USER_INI_PATH
echo 'display_errors = On' | sudo tee -a $PHP_USER_INI_PATH
echo 'error_reporting = E_ALL' | sudo tee -a $PHP_USER_INI_PATH
echo 'short_open_tag = On' | sudo tee -a $PHP_USER_INI_PATH

reboot_webserver_helper

# Disable PHP Zend OPcache
echo 'opache.enable = 0' | sudo tee -a $PHP_USER_INI_PATH

# Absolutely Force Zend OPcache off...
sudo sed -i s,\;opcache.enable=0,opcache.enable=0,g /etc/php/7.2/fpm/php.ini # NGNIX w FPM Only

reboot_webserver_helper

# /*=============================
# =            MYSQL            =
# =============================*/
if [ $INSTALL_MYSQL == 1 ]; then
    sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
    sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
    sudo apt-get -y install mysql-server
    sudo mysqladmin -uroot -proot create scotchbox
    sudo apt-get -y install php7.2-mysql
    reboot_webserver_helper
fi

# /*==============================
# =            SQLITE            =
# ===============================*/
if [ $INSTALL_MYSQL == 1 ]; then
    sudo apt-get -y install sqlite
    sudo apt-get -y install php-sqlite3
    reboot_webserver_helper
fi

# /*================================
# =            COMPOSER            =
# ================================*/
if [ $INSTALL_PHP_ADDONS == 1 ]; then
    EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig)
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")
    php composer-setup.php --quiet
    rm composer-setup.php
    sudo mv composer.phar /usr/local/bin/composer
    sudo chmod 755 /usr/local/bin/composer
fi

# /*==============================
# =            WP-CLI            =
# ==============================*/
if [ $INSTALL_PHP_ADDONS == 1 ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    sudo chmod +x wp-cli.phar
    sudo mv wp-cli.phar /usr/local/bin/wp
fi

# /*=============================
# =            REDIS            =
# =============================*/
if [ $INSTALL_REDIS == 1 ]; then
    sudo apt-get -y install redis-server
    sudo apt-get -y install php-redis
    reboot_webserver_helper
fi

# /*=======================================
# =            WELCOME MESSAGE            =
# =======================================*/

# Disable default messages by removing execute privilege
sudo chmod -x /etc/update-motd.d/*

# Set the new message
echo "$WELCOME_MESSAGE" | sudo tee /etc/motd

# /*===================================================
# =            FINAL GOOD MEASURE, WHY NOT            =
# ===================================================*/
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
reboot_webserver_helper

# /*====================================
# =            YOU ARE DONE            =
# ====================================*/
echo 'Booooooooom! We are done. You are a hero. I love you.'