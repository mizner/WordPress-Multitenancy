#!/bin/bash

sudo apt-get -y install git-core

# Zsh
sudo apt-get -y install zsh
wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
sudo chsh -s /bin/zsh vagrant

# JQ JSON tools
sudo apt-get -y install jq # JSON Tools https://stedolan.github.io/jq/download/