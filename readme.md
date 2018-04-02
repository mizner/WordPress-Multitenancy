

##
* `bash /var/www/setup/sites.nginx.sh`
* `vagrant ssh -c "bash /var/www/setup/sites.nginx.sh"`

## Restart NGNIX
`sudo systemctl reload nginx && sudo systemctl restart php7.2-fpm`

## NGNIX Log
`tail -f /var/log/nginx/error.log`


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
