#!/bin/bash
apt update
apt upgrade -y
apt install -y aptitude
aptitude install -y encfs git wget certbot nfs-kernel-server nfs-common openvpn-as-bundled-clients openvpn-as tightvncserver xfce4 xfce4-goodies xfdesktop4 xrdp apt-transport-https ca-certificates curl gnupg-agent software-properties-common rar
#!/bin/bash


mkdir -p /etc/skel/.ssh 
ssh-keygen -t rsa -b 4096 -P "" -f /etc/skel/.ssh/$(hostname)-server
cat > /etc/skel/.ssh/authorized_keys << EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCs4RPSAs5pZn5ypyy2rpgzU9h3YrTnlu1jzi4MG4q6dSE1QZIjfGhJE859kHbY9ackoa8Jtt/D0KG6YKsw35TfJmeoj8zUthcm4pZt0WC5YLU8/LHzxnA5I5InmTM/djGBvlkBqWwhljM0kXuf1xBv9XPPZSjdwb5ocp1LOhoLeHjV3blT7RndGtXuREhjt+id860a4zdpWyH2pBPD+f6G5nWcakfIxGbTyCQzjmREkJVy5thxK3palDEf9VV7a5rbLFPFOYKDPgm0bPOLAred+GLCV8Cnzjy36BzWDt9n73QKcBB7SoGvxPLFIb2CIjfKVSne5MRyZ5IMgh5TjGIb root@ns3046440
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMothcQ2MLFARp++5hX0L0gXfr8uC/nKhrxIAqP9mjMHOuQE7jxRTwam2LK1B9H71hn2nZlYjs1Z3Rh+4hL8e/CIL/1KNE3VkGXGx7/uGB3DkC61Rw/MS72vEGJE/jVHCjyF5ZprhkSyfhS8C25RBMZ3DwicY0btLtAYyuPXanOpWDOaeZ+ZORXEvrI5ZBzhGwVqh3B6plHD+cAjZ5tGqnmqeBqOlt+TUh5hhg/f3Een6x759GiUpTfxCzjIqYSOyC7z2KZbu3URg2vhY2xhsHLrFfQxFh02rLKSJB/0v/eX/3I9Bj7Dy1rdj4Vidzp1g+EYmpfmevIEKbkjEHpLN1 pknw1@DESKTOP-CF1AAHE
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCk3DpNqYfiXrTP2GNWuH5JQvlBH1+VbIofWreXssdb0rdLl1XvHEWRJtcN2IVPMP4FEg2oFKtmYl5UpUjMoC6tldld7VM4tEtFe4lFLrlA7z0XpoWK4oUu7nuhj9va0j2sndve6gMfrvm4KM7Em6n/D57klA4SE58o3yEtQyEqQVAQ2f3rn4kSe6Yyyb0Q6vtxPUt0/bHKd93lJJDzBUxEgzUGUGQZWjiyPJe/qFeXdIdPmtK1kz7UGGubIECOhE5Tcda3phhTFDifwPMId4u2ERj2cqC35i3IZfE1qDq6/6Sun420rzdrrZt+D62IP5aMOEZ6fqus8J9xmqrfJfKh pknw1@WIN
EOF


groupadd -g 666 docker
useradd -d /home/plex -g 666 -m -s /bin/bash -u 666 -G sudo plex#!/bin/bash


## plex
wget -q https://downloads.plex.tv/plex-keys/PlexSign.key -O - | apt-key add -
add-apt-repository  "deb https://downloads.plex.tv/repo/deb/ public main"
apt update
aptitude install -y plexmediaserver

## webmin
wget -q http://www.webmin.com/jcameron-key.asc -O - | apt-key add -
add-apt-repository "deb http://download.webmin.com/download/repository sarge contrib"
apt update
aptitude install -y webmin

## docker
apt-get remove -y docker docker-engine docker.io containerd runc
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt update -y
aptitude install -y docker-ce docker-ce-cli containerd.io
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
#!/bin/bash

curl https://rclone.org/install.sh | bash


mkdir -p /mnt/ovh/movies
mkdir -p /mnt/ovh/tv
chown -R 666:666 /mnt/ovh

cat > /etc/systemd/system/rclone-movies.service << EOF
[Unit]
Description=OVHmovies (rclone)
AssertPathIsDirectory=/mnt/ovh/movies
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/rclone mount \
        --config=/root/.config/rclone/rclone.conf \
        --allow-other \
        --uid 666 \
        --gid 666 \
        --umask 0000\
        --cache-info-age=60m ovh:/blob-pub/movies /mnt/ovh/movies
ExecStop=/bin/fusermount -u /mnt/ovh/movies
Restart=always
RestartSec=10

[Install]
WantedBy=default.target

EOF

chmod +x /etc/systemd/system/rclone-movies.service
systemctl enable rclone-movies.service

