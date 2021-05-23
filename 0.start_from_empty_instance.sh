#!/bin/sh

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y git-lfs net-tools python3 python-is-python3 python3-pip docker

# install docker
# https://docs.docker.com/engine/install/ubuntu/
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
# post-install
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# initialize ./serve
git submodule update --init
