#!/bin/bash
set -e

if command -v git &> /dev/null; then
    echo "🐙 Git is already installed! Time to write 'fix typo' 47 times. ⌨️"
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