#!/bin/bash
set -e

show_ports() {
    cat <<'PORT_INFO'

=== Port information ===
Trivy: no local listening port for normal CLI scans; this script does not start a server.
PORT_INFO
}

if command -v trivy > /dev/null 2>&1; then
    echo "🛡️ Trivy is already installed! Your system is guarded like Fort Knox. 🏰"
    show_ports
    echo 'To uninstall tools installed by this script, run:'
    echo 'sudo apt-get remove -y trivy'
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

show_ports
echo 'To uninstall tools installed by this script, run:'
echo 'sudo apt-get remove -y trivy'
