#!/bin/bash
set -e

if command -v blackbox_exporter &> /dev/null; then
    echo "📦 Blackbox Exporter is already here monitoring in the dark! 🕶️"
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