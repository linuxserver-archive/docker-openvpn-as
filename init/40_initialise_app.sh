#!/bin/bash

NOASCONFIG="DELETE\n"
ASCONFIG="yes\nyes\n1\n943\n9443\nyes\nyes\nno\nyes\nno\nadmin\n\n"

if [ ! -f "/config/etc/as.conf" ]; then
CONFINPUT=$ASCONFIG
else
CONFINPUT=$NOASCONFIG$ASCONFIG
fi

if [[ $(find /config/etc/db -type f | wc -l) -eq 0 ]]; then
printf "${CONFINPUT}" | /config/bin/ovpn-init
/etc/init.d/openvpnas stop
chown -R abc:abc /config
fi
