FROM lsiobase/alpine.nginx:3.5
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install packages
RUN \
 apk add --no-cache \
	acl \
	bzip2 \
	curl \
	ghostscript \
	git \
	gzip \
	imagemagick \
	memcached \
	openssl \
	php7-apcu \
	php7-bcmath \
	php7-bz2 \
	php7-calendar \
	php7-ctype \
	php7-curl \
	php7-dba \
	php7-dev \
	php7-dom \
	php7-exif \
	php7-ftp \
	php7-gd \
	php7-gettext \
	php7-iconv \
	php7-imap \
	php7-intl \
	php7-ldap \
	php7-mcrypt \
	php7-mysqlnd \
	php7-opcache \
	php7-pear \
	php7-pgsql \
	php7-pspell \
	php7-snmp \
	php7-sqlite3 \
	php7-xmlrpc \
	rsync \
	sqlite \
	ssmtp \
	subversion \
	tar \
	unzip \
	wget && \

 apk add --no-cache \
	--repository http://nl.alpinelinux.org/alpine/edge/testing \
	php7-memcached \
	php7-ssh2

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config /data
