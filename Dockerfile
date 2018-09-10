FROM lsiobase/alpine.nginx:3.7

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

# package version
ENV PYDIO_VER="8.2.1"

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache \
	acl \
	bzip2 \
	curl \
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
	php7-dom \
	php7-exif \
	php7-ftp \
	php7-gd \
	php7-gettext \
	php7-iconv \
	php7-imagick \
	php7-imap \
	php7-intl \
	php7-ldap \
	php7-mcrypt \
	php7-memcached \
	php7-mysqli \
	php7-mysqlnd \
	php7-opcache \
	php7-pear \
	php7-pgsql \
	php7-pspell \
	php7-snmp \
	php7-sqlite3 \
	php7-ssh2 \
	php7-xmlrpc \
	re2c \
	rsync \
	sqlite \
	ssmtp \
	subversion \
	tar \
	unzip \
	wget \
	xz && \
 if [[ -e /usr/lib/php7/ssh2.so && ! -e /usr/lib/php7/modules/ssh2.so ]]; then \
	ln -s /usr/lib/php7/ssh2.so  /usr/lib/php7/modules/ssh2.so ; fi && \
 echo "**** install mailmimedecode ****" && \
 pear install \
	Mail_mimeDecode && \
 echo "**** configure php, including symlink to fix cli warning in pydio. ****" && \
 ln -sf \
	/usr/bin/php7 \
	/usr/bin/php && \
 sed -i \
	-e "s#\output_buffering =.*#\output_buffering = \off#g" \
	-e "s/post_max_size =.*$/post_max_size = 1560M/" \
	-e "s/upload_max_filesize =.*$/upload_max_filesize = 2048M/" \
	-e 's#;session.save_path = "/tmp"#session.save_path = "/config/sess"#g' \
		/etc/php7/php.ini

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config /data
