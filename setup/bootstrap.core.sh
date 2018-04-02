#!/bin/bash

# /*=========================================
# =            CORE / BASE STUFF            =
# =========================================*/

# Add Apt Repos
sudo add-apt-repository -y ppa:ondrej/php # Super Latest Version (currently 7.2)
sudo add-apt-repository -y ppa:ondrej/nginx-mainline # Super Latest Version

# The following is "sudo apt-get -y upgrade" without any prompts
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
sudo apt-get update

sudo apt-get install -y build-essential
sudo apt-get install -y tcl
sudo apt-get install -y software-properties-common