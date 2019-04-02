FROM lsiobase/ubuntu:xenial

# set version label
ARG BUILD_DATE
ARG VERSION
ARG OPENVPNAS_VERSION 
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

RUN \
 echo "**** install packages ****" && \
 apt-get update && \
 apt-get install -y \
	iptables \
	net-tools \
	rsync \
	libmysqlclient-dev && \
 echo "**** install openvpn-as ****" && \
 if [ -z ${OPENVPNAS_VERSION+x} ]; then \
	OPENVPNAS_VERSION=$(curl -w "%{url_effective}" -ILsS -o /dev/null \
	https://openvpn.net/downloads/openvpn-as-latest-ubuntu16.amd_64.deb \
	| awk -F '(openvpn-as-|-Ubuntu16)' '{print $2}'); \
 fi && \
 curl -o \
 /tmp/openvpn.deb -L \
	"https://swupdate.openvpn.org/as/openvpn-as-${OPENVPNAS_VERSION}-Ubuntu16.amd_64.deb" && \
 dpkg -i /tmp/openvpn.deb && \
 echo "**** ensure home folder for abc user set to /config ****" && \
 usermod -d /config abc && \
 echo "**** create admin user and set default password for it ****" && \
 useradd -s /sbin/nologin admin && \
 echo "admin:password" | chpasswd && \
 echo "**** configure openvpn-as ****" && \
 find /usr/local/openvpn_as/scripts -type f -print0 | \
	xargs -0 sed -i 's#/usr/local/openvpn_as#/config#g' && \
 find /usr/local/openvpn_as/bin -type f -print0 | \
	xargs -0 sed -i 's#/usr/local/openvpn_as#/config#g' && \
 sed -i \
		-e 's#=openvpn_as#=abc#g' \
		-e 's#~/tmp#/openvpn/tmp#g' \
		-e 's#~/sock#/openvpn/sock#g' \
	/usr/local/openvpn_as/etc/as_templ.conf && \
 echo "**** cleanup ****" && \
 apt-get clean && \
 rm -rf \
	/tmp/* \
	/usr/local/openvpn_as/etc/db/* \
	/usr/local/openvpn_as/etc/sock \
	/usr/local/openvpn_as/etc/tmp \
	/usr/local/openvpn_as/tmp \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 943/tcp 1194/udp 9443/tcp
VOLUME /config
