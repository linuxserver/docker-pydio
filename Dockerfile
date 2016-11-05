FROM linuxserver/baseimage.nginx
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# copy sources.list
COPY sources.list /etc/apt/

# set install packages as variable
ENV APTLIST="\
	acl \
	bzip2 \
	ghostscript \
	git \
	gzip \
	imagemagick \
	libsqlite3-dev \
	libssh2-php \
	memcached \
	openssl \
	php5-apcu \
	php5-cli \
	php5-curl \
	php5-dev \
	php5-gd \
	php5-imagick \
	php5-imap \
	php5-intl \
	php5-ldap \
	php5-mcrypt \
	php5-memcached \
	php5-mysql \
	php5-pgsql \
	php5-pspell \
	php5-snmp \
	php5-sqlite \
	php5-xmlrpc \
	php-mail-mimedecode \
	php-pear \
	rsync \
	snmp-mibs-downloader \
	sqlite3 \
	ssmtp \
	subversion \
	tar \
	unzip \
	wget"

# install packages
RUN \
 apt-get update -q && \
 apt-get install \
	$APTLIST -qy && \

# cleanup
 apt-get clean -y && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# configure pear and install pear packages
RUN \
 pear config-set \
	preferred_state alpha && \
 pear install \
	VersionControl_Git && \
 pear config-set \
	preferred_state stable && \
 pear install \
	HTTP_WebDAV_Client && \
 pear install \
	channel://pear.php.net/HTTP_OAuth-0.3.1 && \

# enable php mods and set some config for pydio
 php5enmod imap mcrypt && \
 sed -i \
	-e "s@\output_buffering =.*@\output_buffering = \off@g" /etc/php5/cli/php.ini \
	-e "s/post_max_size =.*$/post_max_size = 1560M/" \
	-e "s/upload_max_filesize =.*$/upload_max_filesize = 2048M/" \
		/etc/php5/cli/php.ini && \
 sed -i \
	-e "s@\output_buffering =.*@\output_buffering = \off@g" \
	-e "s/post_max_size =.*$/post_max_size = 1560M/" \
	-e "s/upload_max_filesize =.*$/upload_max_filesize = 2048M/" \
		/etc/php5/fpm/php.ini && \

# delete default ssmtp config file and set ssmtp as default emailer for pydio
 rm \
	/etc/ssmtp/ssmtp.conf && \
 mv /usr/sbin/sendmail /usr/sbin/sendmail.org && \
 ln -s /usr/sbin/ssmtp /usr/sbin/sendmail

# add custom files
ADD defaults/ /defaults/
ADD init/ /etc/my_init.d/
RUN chmod +x \
	/etc/my_init.d/*.sh \
	/etc/service/*/run

# ports and volumes
EXPOSE 443
VOLUME /config /data
