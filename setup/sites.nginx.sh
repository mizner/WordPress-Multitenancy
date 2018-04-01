#!/bin/bash

# /*=======================================
# =            Create Sites               =
# =======================================*/

# Requires jq to be installed https://stedolan.github.io/jq/

SITES_OBJECT=$(cat sites.json | jq -r  '.sites')
SITES_COUNT=$( echo $SITES_OBJECT | jq '. | length' )

echo $SITES_OBJECT
exit 1

PATH_NGNIX_SITES_AVAILABLE = '/etc/nginx/sites-available'

function getObjectItem() {
    local row=$1
    local key=$2

    local result=$(echo ${row} | jq -r '.url');

    echo $result
}

function createNgnixBlockFile(){
    local siteUrl=$1
    local path=$PATH_NGNIX_SITES_AVAILABLE
    sudo cp "$path/default" "$path/$siteUrl"
}

function siteSetup(){
    local row=$(echo $1 | base64 --decode )
    local url=getObjectItem $row url

}

for row in $(echo "$SITES_OBJECT" | jq -r '.[]  | @base64'); do
    # siteSetup $row
done