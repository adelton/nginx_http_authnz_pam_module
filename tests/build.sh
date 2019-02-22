#!/bin/bash

cd nginx
mkdir ngx_http_authnz_pam_module
mv ../ngx_http_authnz_pam_module.c ../config ngx_http_authnz_pam_module
./configure --add-module=ngx_http_authnz_pam_module --with-debug
make
make install
