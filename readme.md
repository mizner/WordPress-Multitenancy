




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
