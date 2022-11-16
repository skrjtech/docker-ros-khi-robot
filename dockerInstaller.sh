#!/bin/bash
VERSION=$1
sudo apt install -y gnome-terminal
sudo apt remove docker-desktop
rm -r $HOME/.docker/desktop
sudo rm /usr/local/bin/com.docker.cli
sudo apt purge docker-desktop
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo apt-get update
if [ $VERSION = "" ]; then
    sudo apt-get install -y docker-ce docker-ce-cli
else
    sudo apt-get install -y docker-ce=$VERSION docker-ce-cli=$VERSION
fi
sudo apt-get install -y containerd.io docker-compose-plugin
sudo usermod -aG docker ${USER}
su - ${USER}