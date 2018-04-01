#!/bin/bash

# /*=======================================
# =            Domains                    =
# =======================================*/

DOMAINS=("site1.test" "site2.test" "site3.test")

echo "Creating directory for $DOMAIN..."

mkdir -p /var/www/public/sites

 ## Loop through all sites
for ((i=0; i < ${#DOMAINS[@]}; i++)); do

    ## Current Domain
    DOMAIN=${DOMAINS[$i]}

    echo "Creating directory for $DOMAIN..."
    mkdir -p /var/www/public/sites/$DOMAIN/

    echo "Creating vhost config for $DOMAIN..."
    sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/$DOMAIN.conf

    echo "Updating vhost config for $DOMAIN..."
    # sudo sed -i s,,'hello',g /etc/apache2/sites-available/site3.dev.conf
    sudo sed -i s,scotchbox.local,$DOMAIN,g /etc/apache2/sites-available/$DOMAIN.conf
    sudo sed -i s,/var/www/public,/var/www/$DOMAIN/public,g /etc/apache2/sites-available/$DOMAIN.conf

    echo "Enabling $DOMAIN. Will probably tell you to restart Apache..."
    sudo a2ensite $DOMAIN.conf

    echo "So let's restart apache..."
    sudo service apache2 restart

done