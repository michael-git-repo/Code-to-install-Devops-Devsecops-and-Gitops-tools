#!/bin/bash
set -e

if command -v trivy &> /dev/null; then
    echo "🛡️ Trivy is already installed! Your system is guarded like Fort Knox. 🏰"
    exit 0
fi

echo "=== Installing Trivy ==="
sudo apt-get install -y wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/trivy.list

sudo apt-get update
sudo apt-get install -y trivy

echo "
    /\\___/\\
   (  o o  )  Trivy Installed!
   (  =\"=  )  Scanning your code vulnerabilities so hackers cry. 🛡️
    (_____)
"