#!/bin/bash
mkdir -p /openvpn-pid /config/log

if [ ! -f "/config/bin/ovpn-init" ]; then
cp -pr /usr/local/openvpn_as/* /config/
rm -rf /config/etc/db/*
find /config/scripts -type f -print0 | xargs -0 sed -i 's#/usr/local/openvpn_as#/config#g'
find /config/bin -type f -print0 | xargs -0 sed -i 's#/usr/local/openvpn_as#/config#g'
sed -i 's#=openvpn_as#=abc#g' /config/etc/as_templ.conf
fi

if [[ $(find /config/etc/sock -type f | wc -l) -ne 0 ]]; then
rm -rf /config/etc/sock/*
fi

if [[ $(find /openvpn-pid -type f | wc -l) -ne 0 ]]; then
rm -rf /openvpn-pid/*
fi

chown -R abc:abc /config/log
chmod -R 755 /openvpn-pid
