FROM lsiobase/xenial.armhf
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# package versions
ARG UNIFI_VER="5.5.24"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

# install packages
RUN \
 apt-get update && \
 apt-get install -y \
	binutils \
	jsvc \
	mongodb-server \
	openjdk-8-jre-headless \
	wget && \

# install unifi
 curl -o \
 /tmp/unifi.deb -L\
	"http://dl.ubnt.com/unifi/${UNIFI_VER}/unifi_sysvinit_all.deb" && \
 dpkg -i /tmp/unifi.deb && \
 rm /usr/lib/unifi/lib/native/Linux/armhf/libubnt_webrtc_jni.so && \

# cleanup
 apt-get clean && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY root/ /

# Volumes and Ports
WORKDIR /usr/lib/unifi
VOLUME /config
EXPOSE 8080 8081 8443 8843 8880
