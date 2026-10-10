#!/bin/bash
set -e

show_ports() {
    cat <<'PORT_INFO'

=== Port information ===
Blackbox Exporter default port: 9115/TCP (HTTP).
Default URL when running: http://<server-ip>:9115
This script installs the binary only; configure and start it separately.
Custom service settings may use a different port.
PORT_INFO
}

if command -v blackbox_exporter > /dev/null 2>&1; then
    echo "📦 Blackbox Exporter is already here monitoring in the dark! 🕶️"
    show_ports
    echo 'To uninstall tools installed by this script, run:'
    echo 'sudo rm -f -- /usr/local/bin/blackbox_exporter'
    echo 'If you started this tool separately, stop that process or service before removing its binaries.'
    exit 0
fi

echo "=== Installing Blackbox Exporter ==="
VERSION="0.25.0"
wget https://github.com/prometheus/blackbox_exporter/releases/download/v${VERSION}/blackbox_exporter-${VERSION}.linux-amd64.tar.gz
tar -xvf blackbox_exporter-${VERSION}.linux-amd64.tar.gz
sudo mv blackbox_exporter-${VERSION}.linux-amd64/blackbox_exporter /usr/local/bin/
rm -rf blackbox_exporter-${VERSION}.linux-amd64*

echo "
   ___________________
  |  _________________  |
  | |                 | |   Blackbox Exporter Ready!
  | |   [ TOP SECRET ]  | |   Probing endpoints like an alien space probe 🛸
  | |_________________| |
  |_____________________|
"

show_ports
echo 'To uninstall tools installed by this script, run:'
echo 'sudo rm -f -- /usr/local/bin/blackbox_exporter'
echo 'If you started this tool separately, stop that process or service before removing its binaries.'
