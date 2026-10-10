#!/bin/bash
set -e

if command -v docker &> /dev/null; then
    echo "🐳 Docker is already present! Stop trying to drown the whale. 🌊"
    exit 0
fi

echo "=== Installing Docker ==="
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker $USER

echo "
       __   __       
      /  \ /  \      Docker Installed!
     (  🐳  🐳 )     Containers galore! \"Works on my machine\" is no longer an excuse. 😉
      \  __  / 
"