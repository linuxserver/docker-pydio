FROM lsiobase/alpine.nginx:3.5
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# package version
ENV PYDIO_VER="7.0.4"

# add repositories
RUN \
 echo "@community http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
 echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
 echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \

# install packages
 apk add --no-cache \
	acl \
	bzip2 \
	curl \
	git \
	gzip \
	memcached \
	openssl \
	re2c \
	rsync \
	sqlite \
	ssmtp \
	subversion \
	tar \
	unzip \
	wget \
	xz && \
 apk add --no-cache \
	icu-libs@edge \
	imagemagick@edge \
	libwebp@edge && \
 apk add --no-cache \
	php7-apcu@community \
	php7-bcmath@community \
	php7-bz2@community \
	php7-calendar@community \
	php7-ctype@community \
	php7-curl@community \
	php7-dba@community \
	php7-dom@community \
	php7-exif@community \
	php7-ftp@community \
	php7-gd@community \
	php7-gettext@community \
	php7-iconv@community \
	php7-imagick@community \
	php7-imap@community \
	php7-intl@community \
	php7-ldap@community \
	php7-mcrypt@community \
	php7-memcached@community \
	php7-mysqli@community \
	php7-mysqlnd@community \
	php7-opcache@community \
	php7-pear@community \
	php7-pgsql@community \
	php7-pspell@community \
	php7-snmp@community \
	php7-sqlite3@community \
	php7-xmlrpc@community && \
 apk add --no-cache \
	php7-ssh2@testing && \
 if [[ -e /usr/lib/php7/ssh2.so && ! -e /usr/lib/php7/modules/ssh2.so ]]; then \
	ln -s /usr/lib/php7/ssh2.so  /usr/lib/php7/modules/ssh2.so ; fi && \

# install mailmimedecode
 pear install \
	Mail_mimeDecode && \

# configure php, including symlink to fix cli warning in pydio.
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
