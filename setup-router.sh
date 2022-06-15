#!/bin/bash
#get PRIVATE_KEY and ROUTER_VERSION from user
if [ ! $PRIVATE_KEY ]; then
  read -p "Insert your Private Key: " PRIVATE_KEY
fi

if [ ! $ROUTER_VERSION ]; then
  read -p "Insert your Router version: " ROUTER_VERSION
fi

sudo apt update && sudo apt upgrade
sleep 2
sudo apt install wget

# install docker
curl -fsSL get.docker.com -o get-docker.sh && sudo sh get-docker.sh

# install docker-compose
VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*\d')
DESTINATION=/usr/local/bin/docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m) -o $DESTINATION
sudo chmod +x /usr/local/bin/docker-compose
# check docker compose version
echo " "
docker-compose --version

# install connext router
git clone https://github.com/connext/nxtp-router-docker-compose.git
sleep 2
cd $PWD/nxtp-router-docker-compose
git checkout amarok
sudo chmod 666 /var/run/docker.sock
docker pull ghcr.io/connext/router:${ROUTER_VERSION}

# config .env file
cp .env.example .env
sleep 1
sed -i 's/latest/'${ROUTER_VERSION}'/g' .env

# config .key file
sleep 2
cp key.example.yaml key.yaml
sleep 1
sed -i 's/dkadkjasjdlkasdladadasda/'${PRIVATE_KEY}'/g' key.yaml

# load config.json
wget -O config.json https://raw.githubusercontent.com/maglionaire/setup-router/main/config.json

# run docker compose
docker-compose up -d
