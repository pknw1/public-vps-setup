#!/bin/bash


## plex
wget -q https://downloads.plex.tv/plex-keys/PlexSign.key -O - | apt-key add -
add-apt-repository  "deb https://downloads.plex.tv/repo/deb/ public main"
apt update
aptitude install -y plexmediaserver

## webmin
wget -q http://www.webmin.com/jcameron-key.asc -O - | apt-key add -
add-apt-repository "deb http://download.webmin.com/download/repository sarge contrib"
apt update
aptitude install -y webmin

## docker
apt-get remove -y docker docker-engine docker.io containerd runc
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt update -y
aptitude install -y docker-ce docker-ce-cli containerd.io
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
