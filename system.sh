#!/bin/bash
apt update
apt upgrade -y
apt install -y aptitude
aptitude install -y encfs git wget certbot nfs-kernel-server nfs-common openvpn-as-bundled-clients openvpn-as tightvncserver xfce4 xfce4-goodies xfdesktop4 xrdp apt-transport-https ca-certificates curl gnupg-agent software-properties-common rar
