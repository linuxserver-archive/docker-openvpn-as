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
RUN chmod -v +x /etc/service/*/run && chmod -v +x /etc/my_init.d/*.sh && \

# give abc user a password and home folder
usermod -d /config abc && \
echo "abc:password" | chpasswd

# Volumes and Ports
VOLUME /config
#EXPOSE PORT
