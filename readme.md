## Links
https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-in-ubuntu-16-04
https://www.digitalocean.com/community/tutorials/how-to-move-an-nginx-web-root-to-a-new-location-on-ubuntu-16-04


##
* `bash /var/www/setup/sites.nginx.sh`
* `vagrant ssh -c "bash /var/www/setup/sites.nginx.sh"`

* Check NGNIX Status: `service nginx status`
* Start NGNIX: `sudo service nginx start`
* Check each root in NGNIX site: `grep "root" -R /etc/nginx/sites-enabled`
* Check if PHP FPM running: `systemctl list-units 'php*'`
* Restart NGNIX: `sudo systemctl reload nginx && sudo systemctl restart php7.2-fpm` 
* Check NGNIX Log: `tail -f /var/log/nginx/error.log`
* Check NGNIX Config: `sudo nginx -t`

## Troubleshooting?
* Check PHP Fixpath: `grep "cgi.fix_pathinfo" -R /etc/php/7.2/fpm/php.ini`
* Change PHP CGI Fix Path Info: `sudo sed -i "s|;cgi.fix_pathinfo=1|cgi.fix_pathinfo=0|g" /etc/php/7.2/fpm/php.ini`




## [Digital Ocean CLI](https://github.com/digitalocean/doctl)
Droplet: `87951788`
* List droplets 
    * `doctl compute droplet list`
* List backups "snapshots"
    * `doctl compute snapshot list`
* Create backup "snapshot"
    * `doctl compute droplet-action snapshot droplet_ID`
* Restore backup 
    * `doctl compute droplet-action restore droplet_ID --image-id image_id`
    * e.g. `doctl compute droplet-action restore 87951788 --image-id 33075700`


vagrant ssh -c "sudo cp /var/www/nginx/sites-available/example /etc/nginx/sites-available"

vagrant ssh -c "sudo ls /etc/nginx/sites-available"
vagrant ssh -c "sudo ls /etc/nginx/sites-enabled"

vagrant ssh -c "bash /var/www/setup/initial.ngnixfix.sh"
vagrant ssh -c "sudo bash /var/www/setup/sites.nginx.sh"

# ugh
`sudo cp /etc/nginx/snippets/fastcgi-php.conf.dpkg-new /etc/nginx/snippets/fastcgi-php.conf`

