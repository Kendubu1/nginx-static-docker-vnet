#!/bin/bash

#Passing ports to env variables
sed -i "s/SSH_PORT/$SSH_PORT/g" /etc/ssh/sshd_config
sed -i "s/PORT/$PORT/g" /etc/nginx/nginx.conf

# Get environment variables to show up in SSH session
eval $(printenv | sed -n "s/^\([^=]\+\)=\(.*\)$/export \1=\2/p" | sed 's/"/\\\"/g' | sed '/=/s//="/' | sed 's/$/"/' >> /etc/profile)

# Start SSH & Nginx
/usr/sbin/sshd
nginx
set -e
if [[ "$1" == -* ]]; then
    set -- nginx
    "$@"
fi
exec "$@"
