#!/bin/bash

set -e
set -x

echo "Wait for the HTTP server to start ..."
for i in $( seq 1 10 ) ; do
	if curl -s -o /dev/null http://localhost/ ; then
		break
	fi
	sleep 3
done

rm -f /etc/pam-auth/alice
echo "Testing auth_basic + authnz_pam on"
curl -s -D /dev/stdout -o /dev/null http://localhost/authz | tee /dev/stderr | grep 401
curl -u alice:Tajnost -s -D /dev/stdout -o /dev/null http://localhost/authz | tee /dev/stderr | grep 403
touch /etc/pam-auth/alice
curl -u alice:Tajnost -s http://localhost/authz | tee /dev/stderr | grep 'User alice'

echo "Testing authnz_pam on + authnz_pam_basic on"
curl -s -D /dev/stdout -o /dev/null http://localhost/authn | tee /dev/stderr | grep 401
curl -u bob:Secret -s -D /dev/stdout -o /dev/null http://localhost/authn | tee /dev/stderr | grep 401
touch /etc/pam-auth/bob
curl -u bob:Secret -s -D /dev/stdout -o /dev/null http://localhost/authn | tee /dev/stderr | grep 401
echo Secret > /etc/pam-auth/bob
curl -u bob:Secret -s http://localhost/authn | tee /dev/stderr | grep 'User bob'
echo Secret2 > /etc/pam-auth/bob
curl -u bob:Secret -s -D /dev/stdout -o /dev/null http://localhost/authn | tee /dev/stderr | grep 401

echo OK $0.
