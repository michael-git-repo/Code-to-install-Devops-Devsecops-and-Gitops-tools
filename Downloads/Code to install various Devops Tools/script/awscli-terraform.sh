#!/bin/bash
set -e

# Checking AWS CLI
if command -v aws &> /dev/null; then
    echo "☁️  AWS CLI is already installed! No need to launch another satellite. 🚀"
else
    echo "=== Installing AWS CLI v2 ==="
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip -q awscliv2.zip
    sudo ./aws/install
    rm -rf aws awscliv2.zip
    echo "
      /\
     /  \    AWS CLI Installed! 
    / /\ \   Time to bill Jeff Bezos! 💸
   / /  \ \
  /_/    \_\
"
fi

# Checking Terraform
if command -v terraform &> /dev/null; then
    echo "🏗️  Terraform is already installed! Your infrastructure is already rock solid. 🪨"
else
    echo "=== Installing Terraform ==="
    sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
    wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt-get update && sudo apt-get install -y terraform
    echo "
    [====]  Terraform Installed!
    [====]  You can now destroy whole cloud infrastructures with 1 typo. 💥
"
fi