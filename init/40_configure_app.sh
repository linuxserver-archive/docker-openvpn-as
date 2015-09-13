#!/bin/bash

if [ ! -f "/config/etc/as.conf" ]; then
printf 'yes\nyes\n1\n943\n9443\nyes\nyes\nno\nyes\nno\nabc\n\n' | /config/bin/ovpn-init
/etc/init.d/openvpnas stop
chown -R abc:abc /config
fi
