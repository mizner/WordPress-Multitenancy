#!/bin/bash

# /*=======================================
# =            Create Sites               =
# =======================================*/

# Requires jq to be installed https://stedolan.github.io/jq/

red=`tput setaf 1`
green=`tput setaf 2`
cyan=`tput setaf 6`
reset=`tput sgr0`

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

function ngnixCreateBlockFile(){
    local pathAvailable="$PATH_NGNIX/sites-available"

    sudo cp "$pathAvailable/example" "$pathAvailable/$siteUrl"
    sed -i "s|@SITE_URL|$siteUrl|g" "$pathAvailable/$siteUrl"

}

function ngnixEnableSite(){
    local siteUrl=$1
    local pathEnabled="$PATH_NGNIX/sites-enabled"
    # Create symbolic links
    sudo ln -sf "$pathAvailable/$siteUrl" "$pathEnabled/"
}
function directoryPublicCreate(){
    local siteUrl=$1
    cp -TR "$PATH_SITE_DIR/example" "$PATH_SITE_DIR/$siteUrl"
}

function directoryPublicClean(){
    rm -r /var/www/public/*/
}

function ngnixCleanAvailable(){
    local pathAvailable="$PATH_NGNIX/sites-available"
    ## todo fix this (NOT WORKING)
    ## find . ! -name 'file.txt' -type f -exec rm -f {} +
}
function ngnixCleanEnabled(){
    local pathEnabled="$PATH_NGNIX/sites-enabled"
    rm -r /etc/nginx/sites-enabled/*
}

function siteSetup(){
    local row=$(echo $1 | base64 --decode )

    local siteUrl=$(getObjectItem $row url)

    echo "Create ${green}{$siteUrl}${reset}"
    ngnixCreateBlockFile $siteUrl
    ngnixEnableSite $siteUrl
    directoryPublicCreate $siteUrl
}

#echo "Clean Site Directory"
#directoryPublicClean
echo "Clean NGNIX Sites Enabled"
ngnixCleanEnabled

echo "Create Sites"
for row in $(echo "$SITES_OBJECT" | jq -r '.[]  | @base64'); do
    siteSetup $row
done

echo "Finishing up"
sudo systemctl restart php7.2-fpm
sudo systemctl restart nginx