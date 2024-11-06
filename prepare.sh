#!/bin/bash
apt install -y debian-keyring debian-archive-keyring apt-transport-https curl
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list

apt update && apt upgrade -y && curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh

apt update
apt install caddy -y
docker run -d -p 9000:9000 --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:alpine-sts
docker run \
  -u root \
  -itd \
  -p 8080:8080 \
  -p 50000:50000 \
  --privileged \
  -v /var/jenkins_home:/var/jenkins_home \
  -v /var/jenkins:/var/jenkins \
  -v /var/run/docker.sock:/var/run/docker.sock \
jenkins/jenkins:lts-alpine-jdk21