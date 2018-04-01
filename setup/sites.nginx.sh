#!/bin/bash

# /*=======================================
# =            Create Sites               =
# =======================================*/

# Requires jq to be installed https://stedolan.github.io/jq/

PATH_NGNIX='/etc/nginx'
PATH_ROOT='/var/www'
PATH_SITE_DIR='/var/www/public'

SITES_OBJECT=$(cat "$PATH_ROOT/sites.json" | jq -r  '.sites')
SITES_COUNT=$( echo $SITES_OBJECT | jq '. | length' )

function getObjectItem () {
    local row=$1
    local key=$2

    local result=$(echo $row | jq -r '.url')

    echo $result
}

function createNgnixBlockFile(){
    local siteUrl=$1
    local pathAvailable="$PATH_NGNIX/sites-available"
    local pathEnabled="$PATH_NGNIX/sites-enabled"
    
    sudo cp "$pathAvailable/example" "$pathAvailable/$siteUrl"
    sed -i "s|@SITE_URL|$siteUrl|g" "$pathAvailable/$siteUrl"
    sudo ln -s "$pathAvailable/$siteUrl" "$pathEnabled/"
}

function createSiteDirectory(){
    local siteUrl=$1
    cp -rf "$PATH_SITE_DIR/example" "$PATH_SITE_DIR/$siteUrl"
}

function siteSetup(){
    local row=$(echo $1 | base64 --decode )

    local siteUrl=$(getObjectItem $row url)

    # 1. Create Ngnix Block File
    createNgnixBlockFile $siteUrl

    # 2. Create Site Directory
    createSiteDirectory $siteUrl
}

for row in $(echo "$SITES_OBJECT" | jq -r '.[]  | @base64'); do
    siteSetup $row
done

sudo systemctl restart php7.2-fpm
sudo systemctl restart nginx