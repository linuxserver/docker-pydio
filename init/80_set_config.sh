#!/bin/bash
mkdir -p /config/log/pydio /config/php


# sed in pydio data folder locations for /data
sed -i -e 's@\define("AJXP_DATA_PATH",.*@\define("AJXP_DATA_PATH", "/data");@g' /config/www/pydio/conf/bootstrap_context.php
sed -i -e 's@\define("AJXP_SHARED_CACHE_DIR",.*@\define("AJXP_SHARED_CACHE_DIR", "/data/cache");@g' /config/www/pydio/conf/bootstrap_context.php

if [ ! -f "/config/php/php-fpm.ini" ]; then
cp /etc/php5/fpm/php.ini /config/php/php-fpm.ini
fi

if [ ! -f "/config/php/php-cli.ini" ]; then
cp /etc/php5/cli/php.ini /config/php/php-cli.ini
fi

cp /config/php/php-cli.ini /etc/php5/cli/php.ini
cp /config/php/php-fpm.ini /etc/php5/fpm/php.ini

chown -R abc:abc /config/log/pydio /config/php

