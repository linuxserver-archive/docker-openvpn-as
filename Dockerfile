FROM lsiobase/ubuntu:bionic

# set version label
ARG BUILD_DATE
ARG VERSION
ARG OPENVPNAS_VERSION 
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs,aptalca"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

RUN \
 echo "**** install packages ****" && \
 apt-get update && \
 apt-get install -y \
	bridge-utils \
	iproute2 \
	iptables \
	liblzo2-2 \
	libmariadbclient18 \
	libmysqlclient-dev \
	net-tools \
	python \
	python-mysqldb \
	python-pkg-resources \
	python-pyrad \
	python-serial \
	rsync \
	sqlite3 \
	ucarp && \
 echo "**** download openvpn-as ****" && \
 if [ -z ${OPENVPNAS_VERSION+x} ]; then \
	OPENVPNAS_VERSION=$(curl -w "%{url_effective}" -ILsS -o /dev/null \
	https://openvpn.net/downloads/openvpn-as-latest-ubuntu18.amd_64.deb \
	| awk -F '(openvpn-as-|-Ubuntu18)' '{print $2}'); \
 fi && \
 mkdir /openvpn && \
 curl -o \
 /openvpn/openvpn.deb -L \
	"https://swupdate.openvpn.org/as/openvpn-as-${OPENVPNAS_VERSION}-Ubuntu18.amd64.deb" && \
 curl -o \
 /openvpn/openvpn-clients.deb -L \
        "https://openvpn.net/downloads/openvpn-as-bundled-clients-latest.deb" && \
 echo "**** ensure home folder for abc user set to /config ****" && \
 usermod -d /config abc && \
 echo "**** create admin user and set default password for it ****" && \
 useradd -s /sbin/nologin admin && \
 echo "admin:password" | chpasswd && \
 rm -rf \
	/tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 943/tcp 1194/udp 9443/tcp
VOLUME /config
