#!/bin/bash
mkdir -p /openvpn-pid /config/log

if [ ! -f "/config/bin/ovpn-init" ]; then
cp -pr /usr/local/openvpn_as/* /config/
rm -rf /config/etc/db/*
find /config/scripts -type f -print0 | xargs -0 sed -i 's#/usr/local/openvpn_as#/config#g'
find /config/bin -type f -print0 | xargs -0 sed -i 's#/usr/local/openvpn_as#/config#g'
sed -i 's#=openvpn_as#=abc#g' /config/etc/as_templ.conf
fi

if [ -f "/openvpn-pid/openvpn.pid" ]; then
rm /openvpn-pid/openvpn.pid
fi

chown -R abc:abc /config/log
chmod -R 755 /openvpn-pid
