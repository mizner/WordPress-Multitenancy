#!/bin/bash

# /*=============================
# =            MYSQL            =
# =============================*/
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get -y install mysql-server
sudo mysqladmin -uroot -proot create scotchbox
sudo apt-get -y install php7.2-mysql

# /*==============================
# =            SQLITE            =
# ===============================*/
sudo apt-get -y install sqlite
sudo apt-get -y install php-sqlite3