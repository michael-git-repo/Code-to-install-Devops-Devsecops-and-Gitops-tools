#!/bin/bash
set -e

if [ "$(docker ps -a -q -f name=sonarqube)" ]; then
    echo "🐟 SonarQube container is already here swimming in your code quality! 🌊"
    docker start sonarqube || true
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