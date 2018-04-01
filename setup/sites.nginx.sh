#!/bin/bash

# /*=======================================
# =            Create Sites               =
# =======================================*/

# Requires jq to be installed https://stedolan.github.io/jq/

SITES_OBJECT=$(cat sites.json | jq -r  '.sites')
SITES_COUNT=$( echo $SITES_OBJECT | jq '. | length' )

PATH_NGNIX_SITES_AVAILABLE='/etc/nginx/sites-available'
PATH_SITE_DIR='/var/www/public/'

function getObjectItem () {
    local row=$1
    local key=$2

    local result=$(echo $row | jq -r '.url')

    echo $result
}


function createNgnixBlockFile(){
    local siteUrl=$1;
    local path=$PATH_NGNIX_SITES_AVAILABLE;
    echo $path;
    # sudo cp "$path/default" "$path/$siteUrl"
}

function siteSetup(){
    local row=$(echo $1 | base64 --decode )

    # local siteUrl=getObjectItem $row url

    # 1. Create Ngnix Block File
    # DIE createNgnixBlockFile $row

    # 2. Create Site Directory
    # DIE mkdir "$PATH_SITE_DIR/$siteUrl"
}

for row in $(echo "$SITES_OBJECT" | jq -r '.[]  | @base64'); do
    siteSetup $row
done