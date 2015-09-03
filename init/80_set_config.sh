#!/bin/bash
mkdir -p /config/log/pydio /config/php

# sed in pydio data folder locations for /data and logging
sed -i -e 's@\define("AJXP_DATA_PATH",.*@\define("AJXP_DATA_PATH", "/data");@g' /config/www/pydio/conf/bootstrap_context.php
sed -i -e 's@\define("AJXP_SHARED_CACHE_DIR",.*@\define("AJXP_SHARED_CACHE_DIR", "/data/cache");@g' /config/www/pydio/conf/bootstrap_context.php
sed -i -e 's@\// define("AJXP_FORCE_LOGPATH",.*@\define("AJXP_FORCE_LOGPATH", "/config/log/pydio/")\;@g' /config/www/pydio/conf/bootstrap_context.php

# cp php ini files to /config for user edit
if [ ! -f "/config/php/php-fpm.ini" ]; then
cp /etc/php5/fpm/php.ini /config/php/php-fpm.ini
fi

if [ ! -f "/config/php/php-cli.ini" ]; then
cp /etc/php5/cli/php.ini /config/php/php-cli.ini
fi

cp /config/php/php-cli.ini /etc/php5/cli/php.ini
cp /config/php/php-fpm.ini /etc/php5/fpm/php.ini

chown -R abc:abc /config/log/pydio /config/php

# setting email config file.

if [ ! -f "/config/ssmtp.conf" ]; then
cp /defaults/ssmtp.conf /config/ssmtp.conf
chown abc:abc /config/ssmtp.conf
fi

cp /config/ssmtp.conf /etc/ssmtp/ssmtp.conf
