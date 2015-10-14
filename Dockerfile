FROM linuxserver/baseimage

MAINTAINER Sparklyballs <sparklyballs@linuxserver.io>

ENV APTLIST="iptables"

# install packages
RUN apt-get update -q && \
apt-get install \
$APTLIST -qy && \
curl -o /tmp/openvpn.deb http://swupdate.openvpn.org/as/openvpn-as-2.0.20-Ubuntu14.amd_64.deb && \
dpkg -i /tmp/openvpn.deb && \
apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*


#Adding Custom files
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh && \

# give abc user a home folder
usermod -d /config abc && \

# create admin user and set default password for it
useradd -s /sbin/nologin admin && \
echo "admin:password" | chpasswd && \

# set some config for openvpn-as
find /usr/local/openvpn_as/scripts -type f -print0 | xargs -0 sed -i 's#/usr/local/openvpn_as#/config#g' && \
find /usr/local/openvpn_as/bin -type f -print0 | xargs -0 sed -i 's#/usr/local/openvpn_as#/config#g' && \
sed -i 's#=openvpn_as#=abc#g' /usr/local/openvpn_as/etc/as_templ.conf && \
sed -i 's#~/tmp#/openvpn/tmp#g' /usr/local/openvpn_as/etc/as_templ.conf && \
sed -i 's#~/sock#/openvpn/sock#g' /usr/local/openvpn_as/etc/as_templ.conf

# Volumes and Ports
VOLUME /config
EXPOSE 943/tcp 1194/udp 9443/tcp

