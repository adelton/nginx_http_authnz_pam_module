#!/bin/bash

set -e
set -x

useradd -r nginx

mkdir -p /etc/pam-auth
cp -p tests/auth.ssi /usr/local/nginx/html/auth.ssi
patch /usr/local/nginx/conf/nginx.conf < tests/nginx.conf.patch
cp -p tests/pam-exec /usr/bin/pam-exec
cp tests/pam-web /etc/pam.d/web
touch /usr/local/nginx/logs/pam_exec.log
chown nginx /usr/local/nginx/logs/pam_exec.log
# htpasswd -bc /etc/htpasswd alice Tajnost
echo 'alice:$apr1$06fwDEeR$EDC9NX41WppjatjzHheit.' > /etc/htpasswd
