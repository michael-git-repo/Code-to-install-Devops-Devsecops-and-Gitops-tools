#!/bin/bash
set -e

show_ports() {
    cat <<'PORT_INFO'

=== Port information ===
Node Exporter default port: 9100/TCP (HTTP).
Default metrics URL when running: http://<server-ip>:9100/metrics
This script installs the binary only; start it separately.
Custom service settings may use a different port.
PORT_INFO
}

if command -v node_exporter > /dev/null 2>&1; then
    echo "📡 Node Exporter is already active and spying on CPU usage! 📈"
    show_ports
    echo 'To uninstall tools installed by this script, run:'
    echo 'sudo rm -f -- /usr/local/bin/node_exporter'
    echo 'If you started this tool separately, stop that process or service before removing its binaries.'
    exit 0
fi

echo "=== Installing Node Exporter ==="
VERSION="1.8.0"
wget https://github.com/prometheus/node_exporter/releases/download/v${VERSION}/node_exporter-${VERSION}.linux-amd64.tar.gz
tar -xvf node_exporter-${VERSION}.linux-amd64.tar.gz
sudo mv node_exporter-${VERSION}.linux-amd64/node_exporter /usr/local/bin/
rm -rf node_exporter-${VERSION}.linux-amd64*

echo "
   /\\_/\\  
  ( o.o )  Node Exporter Installed! 
   > ^ <   It will watch your RAM like a cat watches a laser pointer. 🐱
"

show_ports
echo 'To uninstall tools installed by this script, run:'
echo 'sudo rm -f -- /usr/local/bin/node_exporter'
echo 'If you started this tool separately, stop that process or service before removing its binaries.'
