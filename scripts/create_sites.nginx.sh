#!/bin/bash

# /*=======================================
# =            Create Sites               =
# =======================================*/

# Requires jq to be installed https://stedolan.github.io/jq/

# jq -nc --slurpfile OBJEC sites.json
SITES_OBJECT=$(cat sites.json | jq -r  '.sites')
SITES_COUNT=$( echo $SITES_OBJECT | jq '. | length' )

function getObjectItem() {
    local row=$(echo $1 | base64 --decode ) 
    local key=$2

    local result=$(echo ${row} | jq -r '.url');
    
    echo $result
}

for row in $(echo "$SITES_OBJECT" | jq -r '.[]  | @base64'); do
    getObjectItem $row url
done