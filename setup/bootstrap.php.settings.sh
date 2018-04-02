#!/bin/bash

# /*===========================================
# =            CUSTOM PHP SETTINGS            =
# ===========================================*/
PHP_USER_INI_PATH=/etc/php/7.2/fpm/conf.d/user.ini # NGNIX w FPM Only

echo 'display_startup_errors = On' | sudo tee -a $PHP_USER_INI_PATH
echo 'display_errors = On' | sudo tee -a $PHP_USER_INI_PATH
echo 'error_reporting = E_ALL' | sudo tee -a $PHP_USER_INI_PATH
echo 'short_open_tag = On' | sudo tee -a $PHP_USER_INI_PATH



# Disable PHP Zend OPcache
echo 'opache.enable = 0' | sudo tee -a $PHP_USER_INI_PATH

# Absolutely Force Zend OPcache off...
sudo sed -i s,\;opcache.enable=0,opcache.enable=0,g /etc/php/7.2/fpm/php.ini # NGNIX w FPM Only