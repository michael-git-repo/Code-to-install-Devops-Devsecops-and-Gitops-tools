#!/bin/bash
set -e

if command -v node_exporter &> /dev/null; then
    echo "📡 Node Exporter is already active and spying on CPU usage! 📈"
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