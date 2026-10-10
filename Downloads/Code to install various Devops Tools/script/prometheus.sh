#!/bin/bash
set -e

show_ports() {
    cat <<'PORT_INFO'

=== Port information ===
Prometheus default port: 9090/TCP (HTTP).
Default URL when running: http://<server-ip>:9090
This script installs the binaries only; configure and start Prometheus separately.
Custom service settings may use a different port.
PORT_INFO
}

if command -v prometheus > /dev/null 2>&1; then
    echo "🔥 Prometheus is already running! Fire god of monitoring is content. ⚡"
    show_ports
    echo 'To uninstall tools installed by this script, run:'
    echo 'sudo rm -f -- /usr/local/bin/prometheus /usr/local/bin/promtool'
    echo 'If you started this tool separately, stop that process or service before removing its binaries.'
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

show_ports
echo 'To uninstall tools installed by this script, run:'
echo 'sudo rm -f -- /usr/local/bin/prometheus /usr/local/bin/promtool'
echo 'If you started this tool separately, stop that process or service before removing its binaries.'
