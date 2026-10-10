#!/bin/bash
set -e

show_ports() {
    cat <<'PORT_INFO'

=== Port information ===
SonarQube port mapping for new installs: host 9000/TCP -> container 9000/TCP (HTTP).
Default URL when running: http://<server-ip>:9000
Existing containers may use a different mapping; check with: docker port sonarqube
PORT_INFO
}

if [ "$(docker ps -a -q -f name=sonarqube)" ]; then
    echo "🐟 SonarQube container is already here swimming in your code quality! 🌊"
    docker start sonarqube || true
    show_ports
    echo 'To uninstall tools installed by this script, run:'
    echo 'sudo docker rm -f sonarqube'
    exit 0
fi

echo "=== Running SonarQube via Docker ==="
docker run -d --name sonarqube -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true -p 9000:9000 sonarqube:lts-community

echo "
     _____
   /  ___  \\   SonarQube Installed!
  |  (  o)  |  Ready to point out all 5,000 code smells in your project. 🦨
   \\_______/
"

show_ports
echo 'To uninstall tools installed by this script, run:'
echo 'sudo docker rm -f sonarqube'
