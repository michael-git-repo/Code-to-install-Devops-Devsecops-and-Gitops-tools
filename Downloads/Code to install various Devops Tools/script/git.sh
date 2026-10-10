#!/bin/bash
set -e

show_ports() {
    cat <<'PORT_INFO'

=== Port information ===
Git: no local listening port (command-line tool).
PORT_INFO
}

if command -v git > /dev/null 2>&1; then
    echo "🐙 Git is already installed! Time to write 'fix typo' 47 times. ⌨️"
    show_ports
    echo 'To uninstall tools installed by this script, run:'
    echo 'sudo apt-get remove -y git'
    exit 0
fi

echo "=== Installing Git ==="
sudo apt-get update
sudo apt-get install -y git

echo "
    _ _ _        Git Installed!
   (_(_(_)_      Remember: 'git push --force' is totally safe. 
  (_(_(_(_|      (Disclaimer: It is definitely not safe.) 🔥
   (_(_(_)_|
"

show_ports
echo 'To uninstall tools installed by this script, run:'
echo 'sudo apt-get remove -y git'
