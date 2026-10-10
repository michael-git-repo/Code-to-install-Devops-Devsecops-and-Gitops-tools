#!/bin/bash
set -e

show_ports() {
    cat <<'PORT_INFO'

=== Port information ===
Docker: no TCP listening port enabled by this script; the daemon uses a local Unix socket.
Container ports depend on the mappings you publish with docker run -p.
PORT_INFO
}

if command -v docker > /dev/null 2>&1; then
    echo "🐳 Docker is already present! Stop trying to drown the whale. 🌊"
    show_ports
    echo 'To uninstall tools installed by this script, run:'
    echo 'sudo apt-get remove -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin'
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

show_ports
echo 'To uninstall tools installed by this script, run:'
echo 'sudo apt-get remove -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin'
