#!/bin/bash
set -e

show_ports() {
    cat <<'PORT_INFO'

=== Port information ===
Jenkins default port: 8080/TCP (HTTP).
Default URL when running: http://<server-ip>:8080
Custom service settings may use a different port.
PORT_INFO
}

if dpkg -l | grep -q jenkins; then
    echo "👴 Jenkins is already installed! The old butler is serving faithfully. ☕"
    show_ports
    echo 'To uninstall tools installed by this script, run:'
    echo 'sudo systemctl disable --now jenkins && sudo apt-get remove -y jenkins'
    exit 0
fi

echo "=== Installing OpenJDK 17 and Jenkins ==="
sudo apt-get update
sudo apt-get install -y fontconfig openjdk-17-jre
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update
sudo apt-get install -y jenkins
sudo systemctl enable --now jenkins

echo "
      (  )   
     (    )   Jenkins Installed! 
    |======|  The Butler is ready to break your builds. ☕🔥
    |      |
"

show_ports
echo 'To uninstall tools installed by this script, run:'
echo 'sudo systemctl disable --now jenkins && sudo apt-get remove -y jenkins'
