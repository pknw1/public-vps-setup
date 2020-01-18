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

