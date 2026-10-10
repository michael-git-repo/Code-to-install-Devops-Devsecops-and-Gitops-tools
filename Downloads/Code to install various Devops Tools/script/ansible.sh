#!/bin/bash
set -e

show_ports() {
    cat <<'PORT_INFO'

=== Port information ===
Ansible: no local listening port (command-line tool).
PORT_INFO
}

if command -v ansible > /dev/null 2>&1; then
    echo "🤖 Ansible is already installed! Automation overlord is ready. ⚡"
    show_ports
    echo 'To uninstall tools installed by this script, run:'
    echo 'sudo apt-get remove -y ansible ansible-core'
    exit 0
fi

echo "=== Installing Ansible ==="
sudo apt-get update
sudo apt-get install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt-get install -y ansible

echo "
     _____
    /     \\    Ansible Installed!
   | () () |   Configuring 100 servers at once with a single playbook. 🕹️
    \\  _  /
     \`---\`
"

show_ports
echo 'To uninstall tools installed by this script, run:'
echo 'sudo apt-get remove -y ansible ansible-core'
