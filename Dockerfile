FROM lsiobase/alpine.nginx:3.5
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# package version
ENV PYDIO_VER="7.0.4"

# install build packages
RUN \
 apk add --no-cache --virtual=build-dependencies \
	autoconf \
	file \
	g++ \
	gcc \
	imagemagick-dev \
	libc-dev \
	libtool \
	make \
	pkgconf \
	php7-dev && \

# install runtime packages
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
	--repository http://nl.alpinelinux.org/alpine/edge/testing \
	php7-memcached \
	php7-ssh2 && \

# install php imagemagick
 mkdir -p \
	/tmp/imagick-src && \
 curl -o \
 /tmp/imagick.tgz -L \
	https://pecl.php.net/get/imagick && \
 tar xf \
 /tmp/imagick.tgz -C \
	/tmp/imagick-src --strip-components=1 && \
 cd /tmp/imagick-src && \
 phpize7 && \
 ./configure \
	--prefix=/usr \
	--with-php-config=/usr/bin/php-config7 && \
 make && \
 make install && \
 echo "extension=imagick.so" > /etc/php7/conf.d/00_imagick.ini && \

# install mailmimedecode
 pear install \
	Mail_mimeDecode && \

# configure php, including symlink to fix cli warning in pydio.
 ln -s \
	/usr/bin/php7 \
	/usr/bin/php && \
 sed -i \
	-e "s#\output_buffering =.*#\output_buffering = \off#g" \
	-e "s/post_max_size =.*$/post_max_size = 1560M/" \
	-e "s/upload_max_filesize =.*$/upload_max_filesize = 2048M/" \
	-e 's#;session.save_path = "/tmp"#session.save_path = "/config/sess"#g' \
		/etc/php7/php.ini && \

# cleanup
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config /data
