#!/bin/bash
# https://raw.githubusercontent.com/scotch-io/scotch-box-build-scripts/master/install.sh

# /*=================================
# =            VARIABLES            =
# =================================*/
WELCOME_MESSAGE='
🚀 🚀 🚀 🚀 🚀 🚀 🚀 🚀 🚀 🚀 🚀 🚀
   _____                   _            _                  _         _
  / ____|                 | |          | |                | |       | |
 | (___  _ _ __ ___  _ __ | | ___      | |     __ _ _   _ |_|_   ___| |__
  \___ \| |  _   _ \|  _ \| |/ _ \     | |    / _  | | | |  _ \ / __|  _ \
  ____) | | | | | | | |_) | |  __/     | |___| (_| | |_| | | | | (__| | | |
 |_____/|_|_| |_| |_| .__/|_|\___|     |______\__,_|\__,_|_| |_|\___|_| |_|
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

# Install Core
sudo bash /var/www/setup/bootstrap.core.sh

# Install Core Addons
if [ $INSTALL_CORE_ADDONS == 1 ]; then
    sudo bash /var/www/setup/bootstrap.core.addons.sh
fi

# Weird Vagrant issue fix
sudo apt-get install -y ifupdown

# Install NGNIX
sudo bash /var/www/setup/bootstrap.ngnix.sh

# Install PHP
sudo bash /var/www/setup/bootstrap.php.sh

if [ $INSTALL_PHP_ADDONS == 1 ]; then
    sudo bash ./bootstrap.php.extras.sh
fi

# PHP Settings
sudo bash /var/www/setup/bootstrap.php.settings.sh
reboot_webserver_helper

# Install MySQL
if [ $INSTALL_MYSQL == 1 ]; then
    sudo bash /var/www/setup/bootstrap.mysql.sh
    reboot_webserver_helper
fi

# Install Redis
if [ $INSTALL_REDIS == 1 ]; then
    sudo bash /var/www/setup/bootstrap.mysql.sh
    reboot_webserver_helper
fi

# Fix NGNIX
sudo bash /var/www/setup/bootstrap.ngnix.fix.sh

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
reboot_webserver_helper

# /*====================================
# =            YOU ARE DONE            =
# ====================================*/
echo 'Booooooooom! We are done. You are a hero. I love you.'