#!/bin/bash


mkdir -p /etc/skel/.ssh 
ssh-keygen -t rsa -b 4096 -P "" -f /etc/skel/.ssh/$(hostname)-server
cat > /etc/skel/.ssh/authorized_keys << EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCs4RPSAs5pZn5ypyy2rpgzU9h3YrTnlu1jzi4MG4q6dSE1QZIjfGhJE859kHbY9ackoa8Jtt/D0KG6YKsw35TfJmeoj8zUthcm4pZt0WC5YLU8/LHzxnA5I5InmTM/djGBvlkBqWwhljM0kXuf1xBv9XPPZSjdwb5ocp1LOhoLeHjV3blT7RndGtXuREhjt+id860a4zdpWyH2pBPD+f6G5nWcakfIxGbTyCQzjmREkJVy5thxK3palDEf9VV7a5rbLFPFOYKDPgm0bPOLAred+GLCV8Cnzjy36BzWDt9n73QKcBB7SoGvxPLFIb2CIjfKVSne5MRyZ5IMgh5TjGIb root@ns3046440
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMothcQ2MLFARp++5hX0L0gXfr8uC/nKhrxIAqP9mjMHOuQE7jxRTwam2LK1B9H71hn2nZlYjs1Z3Rh+4hL8e/CIL/1KNE3VkGXGx7/uGB3DkC61Rw/MS72vEGJE/jVHCjyF5ZprhkSyfhS8C25RBMZ3DwicY0btLtAYyuPXanOpWDOaeZ+ZORXEvrI5ZBzhGwVqh3B6plHD+cAjZ5tGqnmqeBqOlt+TUh5hhg/f3Een6x759GiUpTfxCzjIqYSOyC7z2KZbu3URg2vhY2xhsHLrFfQxFh02rLKSJB/0v/eX/3I9Bj7Dy1rdj4Vidzp1g+EYmpfmevIEKbkjEHpLN1 pknw1@DESKTOP-CF1AAHE
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCk3DpNqYfiXrTP2GNWuH5JQvlBH1+VbIofWreXssdb0rdLl1XvHEWRJtcN2IVPMP4FEg2oFKtmYl5UpUjMoC6tldld7VM4tEtFe4lFLrlA7z0XpoWK4oUu7nuhj9va0j2sndve6gMfrvm4KM7Em6n/D57klA4SE58o3yEtQyEqQVAQ2f3rn4kSe6Yyyb0Q6vtxPUt0/bHKd93lJJDzBUxEgzUGUGQZWjiyPJe/qFeXdIdPmtK1kz7UGGubIECOhE5Tcda3phhTFDifwPMId4u2ERj2cqC35i3IZfE1qDq6/6Sun420rzdrrZt+D62IP5aMOEZ6fqus8J9xmqrfJfKh pknw1@WIN
EOF


groupadd -g 666 docker
useradd -d /home/plex -g 666 -m -s /bin/bash -u 666 -G sudo plex