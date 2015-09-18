#!/bin/bash
mkdir -p /openvpn/pid /openvpn/sock /openvpn/tmp  /config/log

if [ ! -f "/config/bin/ovpn-init" ]; then
cp -pr /usr/local/openvpn_as/* /config/
rm -rf /config/etc/db/* /config/tmp /config/sock
fi

if [[ $(find /openvpn/sock -type f | wc -l) -ne 0 ]]; then
rm -rf /openvpn/sock/*
fi

if [[ $(find /openvpn/pid -type f | wc -l) -ne 0 ]]; then
rm -rf /openvpn/pid/*
fi

chown -R abc:abc /config/log
chmod -R 755 /openvpn
