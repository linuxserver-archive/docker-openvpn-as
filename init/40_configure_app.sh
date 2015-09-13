#!/bin/bash

if [[ $(find /config/etc/db -type f | wc -l) -eq 0 ]]; then
printf 'DELETE\nyes\nyes\n1\n943\n9443\nyes\nyes\nno\nyes\nno\nabc\n\n' | /config/bin/ovpn-init
/etc/init.d/openvpnas stop
chown -R abc:abc /config
fi
