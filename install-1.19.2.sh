#!/bin/sh

sudo apt update && sudo apt upgrade -y

sudo apt-get install wget gnupg openjdk-17-jre screen -y

mkdir -p /usr/share/mc-server/paper-1.19.2

LATEST_BUILD=$(curl -X GET "https://papermc.io/api/v2/projects/paper/versions/1.19.2" -H  "accept: application/json" | jq '.builds[-1]')

curl -o /usr/share/mc-server/paper-1.19.2/paperclip.jar -X GET "https://papermc.io/api/v2/projects/paper/versions/1.19.2/builds/${LATEST_BUILD}/downloads/paper-1.19.2-${LATEST_BUILD}.jar" -H  "accept: application/java-archive" -JO

cp start-1.19.2.sh /usr/share/mc-server/paper-1.19.2

sudo cp mc-1.19.2.service /etc/systemd/system/

sudo echo "eula=true" >> /usr/share/mc-server/paper-1.19.2/eula.txt

sudo systemctl daemon-reload
sudo systemctl enable --now mc-1.19.2.service

