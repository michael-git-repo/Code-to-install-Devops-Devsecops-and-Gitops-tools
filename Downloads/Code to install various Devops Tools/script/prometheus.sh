#!/bin/bash
set -e

if command -v prometheus &> /dev/null; then
    echo "🔥 Prometheus is already running! Fire god of monitoring is content. ⚡"
    exit 0
fi

echo "=== Installing Prometheus ==="
VERSION="2.51.0"
wget https://github.com/prometheus/prometheus/releases/download/v${VERSION}/prometheus-${VERSION}.linux-amd64.tar.gz
tar -xvf prometheus-${VERSION}.linux-amd64.tar.gz
sudo mv prometheus-${VERSION}.linux-amd64/prometheus /usr/local/bin/
sudo mv prometheus-${VERSION}.linux-amd64/promtool /usr/local/bin/
rm -rf prometheus-${VERSION}.linux-amd64*

echo "
     (  .      )
    )           (
   (    🔥       ) Prometheus Installed!
    )           (  Collecting metrics like baseball cards! ⚾
     (_________)
"