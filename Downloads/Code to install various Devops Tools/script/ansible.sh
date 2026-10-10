#!/bin/bash
set -e

if command -v ansible &> /dev/null; then
    echo "🤖 Ansible is already installed! Automation overlord is ready. ⚡"
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