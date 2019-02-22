#!/bin/bash

cd nginx
./configure --with-debug
make
make install
./configure --add-dynamic-module=.. --with-debug
make modules
mkdir -p /usr/local/nginx/modules
cp objs/ngx_http_authnz_pam_module.so /usr/local/nginx/modules/
