#!/bin/bash

# Update the apt package index and install packages to allow apt to use a repository over HTTPS
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    lsb-release

# Remove the existing GPG key file to avoid the prompt
sudo rm -f /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the stable repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y docker-ce docker-ce-cli containerd.io

# Add the current user to the Docker group (replace $USER with your username if necessary)
sudo usermod -aG docker $USER

# Install Docker Compose V2 plugin
sudo mkdir -p /usr/local/lib/docker/cli-plugins
sudo curl -SL https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-$(uname -m) -o /usr/local/lib/docker/cli-plugins>
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

# Activate changes to groups
newgrp docker

echo "Docker and Docker Compose V2 have been installed successfully."
