FROM linuxserver/baseimage.nginx

MAINTAINER Mark Burford <sparklyballs@gmail.com>

# set install packages as variable
ENV APTLIST="acl \
bzip2 \
imagemagick \
ghostscript \
git \
gzip \
nano \
openssl \
libssh2-php \
php5-cli \
php5-curl \
php5-dev \
php5-gd \
php5-imagick \
php5-imap \
php5-mcrypt \
php-pear \
php5-ldap \
php-mail-mimedecode \
php5-mysql \
php5-pgsql \
php5-sqlite \
php5-xmlrpc \
rsync \
ssmtp \
subversion \
tar \
unzip \
wget"

# install packages
RUN apt-get update -q && \
apt-get install \
$APTLIST -qy && \

# delete default ssmtp config file
rm /etc/ssmtp/ssmtp.conf && \

# cleanup 
apt-get clean -y && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# configure pear and install pear packages
RUN pear config-set preferred_state alpha && \
pear install VersionControl_Git && \
pear config-set preferred_state stable && \
pear install HTTP_WebDAV_Client && \
pear install channel://pear.php.net/HTTP_OAuth-0.3.1

# add some files 
ADD defaults/ /defaults/
ADD init/ /etc/my_init.d/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh && \

# enable php mods and set some config for pydio
php5enmod imap mcrypt && \
sed -i -e "s@\output_buffering =.*@\output_buffering = \off@g" /etc/php5/fpm/php.ini && \
sed -i -e "s@\output_buffering =.*@\output_buffering = \off@g" /etc/php5/cli/php.ini && \
sed -i "s/upload_max_filesize =.*$/upload_max_filesize = 2048M/" /etc/php5/fpm/php.ini && \
sed -i "s/upload_max_filesize =.*$/upload_max_filesize = 2048M/" /etc/php5/cli/php.ini && \
sed -i "s/post_max_size =.*$/post_max_size = 1560M/" /etc/php5/fpm/php.ini && \
sed -i "s/post_max_size =.*$/post_max_size = 1560M/" /etc/php5/cli/php.ini

# expose ports
EXPOSE 80 443

# set volumes
VOLUME /config /data


