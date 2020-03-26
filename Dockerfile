FROM lsiobase/ubuntu:bionic

# set version label
ARG BUILD_DATE
ARG VERSION
ARG OPENVPNAS_VERSION 
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aptalca"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

RUN \
 echo "**** install dependencies ****" && \
 apt-get update && \
 apt-get install -y \
	bridge-utils \
	gnupg \
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
 echo "**** add openvpn-as repo ****" && \
 curl -s https://as-repository.openvpn.net/as-repo-public.gpg | apt-key add - && \
 echo "deb http://as-repository.openvpn.net/as/debian bionic main">/etc/apt/sources.list.d/openvpn-as-repo.list && \
 if [ -z ${OPENVPNAS_VERSION+x} ]; then \
	OPENVPNAS_VERSION=$(curl -sX GET http://as-repository.openvpn.net/as/debian/dists/bionic/main/binary-amd64/Packages.gz | gunzip -c \
	|grep -A 7 -m 1 "Package: openvpn-as" | awk -F ": " '/Version/{print $2;exit}');\
 fi && \
 echo "$OPENVPNAS_VERSION" > /version.txt && \
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
