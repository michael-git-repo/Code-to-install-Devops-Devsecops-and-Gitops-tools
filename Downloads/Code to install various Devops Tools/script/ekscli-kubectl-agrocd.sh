#!/bin/bash
set -e

show_ports() {
    cat <<'PORT_INFO'

=== Port information ===
eksctl: no local listening port (command-line tool).
kubectl: no local listening port for normal CLI use.
Argo CD CLI: no local listening port; this script does not install the Argo CD server.
PORT_INFO
}

# eksctl
if ! command -v eksctl > /dev/null 2>&1; then
    echo "=== Installing eksctl ==="
    curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    sudo mv /tmp/eksctl /usr/local/bin
    echo "⛵ eksctl installed! Time to control AWS Kubernetes clusters like a captain!"
else
    echo "⛵ eksctl already exists on deck!"
fi

# kubectl
if ! command -v kubectl > /dev/null 2>&1; then
    echo "=== Installing kubectl ==="
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    rm kubectl
    echo "☸️  kubectl installed! May your Pods never crashloopbackoff!"
else
    echo "☸️  kubectl already exists!"
fi

# argocd
if ! command -v argocd > /dev/null 2>&1; then
    echo "=== Installing ArgoCD CLI ==="
    curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
    sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
    rm argocd-linux-amd64
    echo "🐙 ArgoCD installed! GitOps magic activated. Push to git and take a nap. 💤"
else
    echo "🐙 ArgoCD CLI is already installed!"
fi

show_ports
echo 'To uninstall tools installed by this script, run:'
echo 'sudo rm -f -- /usr/local/bin/eksctl /usr/local/bin/kubectl /usr/local/bin/argocd'
