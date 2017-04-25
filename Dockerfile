FROM lsiobase/xenial
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# package version
ARG OPENVPN_VER="2.1.4b"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

# install openvpn-as
RUN \
 apt-get update && \
 apt-get install -y \
	iptables \
	net-tools && \

curl -o \
 /tmp/openvpn.deb -L \
	http://swupdate.openvpn.org/as/openvpn-as-${OPENVPN_VER}-Ubuntu16.amd_64.deb && \
 dpkg -i /tmp/openvpn.deb && \

# cleanup
 apt-get clean && \
 rm -rf \
	/tmp/* \
	/usr/local/openvpn_as/etc/db/* \
	/usr/local/openvpn_as/etc/sock \
	/usr/local/openvpn_as/etc/tmp \
	/usr/local/openvpn_as/tmp \
	/var/lib/apt/lists/* \
	/var/tmp/*

# ensure abc using /config as home folder
RUN \
 usermod -d /config abc && \

# create admin user and set default password for it
 useradd -s /sbin/nologin admin && \
 echo "admin:password" | chpasswd && \

# set some config for openvpn-as
 find /usr/local/openvpn_as/scripts -type f -print0 | \
	xargs -0 sed -i 's#/usr/local/openvpn_as#/config#g' && \
 find /usr/local/openvpn_as/bin -type f -print0 | \
	xargs -0 sed -i 's#/usr/local/openvpn_as#/config#g' && \

 sed -i \
		-e 's#=openvpn_as#=abc#g' \
		-e 's#~/tmp#/openvpn/tmp#g' \
		-e 's#~/sock#/openvpn/sock#g' \
	/usr/local/openvpn_as/etc/as_templ.conf

# add local files
COPY /root /

# ports and volumes
EXPOSE 943/tcp 1194/udp 9443/tcp
VOLUME /config
