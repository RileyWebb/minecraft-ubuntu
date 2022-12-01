#!/bin/sh

sudo apt update && sudo apt upgrade -y

sudo apt-get install wget gnupg openjdk-17-jre -y

mkdir ~/paper-1.19.2
cd ~/paper-1.19.2

LATEST_BUILD=$(curl -X GET "https://papermc.io/api/v2/projects/paper/versions/1.19.2" -H  "accept: application/json" | jq '.builds[-1]')

curl -o paperclip.jar -X GET "https://papermc.io/api/v2/projects/paper/versions/1.19.2/builds/${LATEST_BUILD}/downloads/paper-1.19.2-${LATEST_BUILD}.jar" -H  "accept: application/java-archive" -JO

cp start-1.19.2.sh ~/paper-1.19.2

mkdir -p ~/.config/systemd/user/
sudo cp mc-1.19.2.service ~/.config/systemd/user/

sudo systemctl daemon-reload
sudo systemctl enable --user --now mc-1.19.2.service