#!/bin/bash

sudo systemctl restart php7.2-fpm
sudo systemctl restart nginx

echo 'Rebooting your webserver'