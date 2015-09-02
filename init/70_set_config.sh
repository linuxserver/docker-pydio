#!/bin/bash
mkdir -p /config/log/pydio /config/php


if [ ! -f "/config/php/php-fpm.ini" ]; then
cp /etc/php5/fpm/php.ini /config/php/php-fpm.ini
fi

if [ ! -f "/config/php/php-cli.ini" ]; then
cp /etc/php5/cli/php.ini /config/php/php-cli.ini
fi

cp /config/php/php-cli.ini /etc/php5/cli/php.ini
cp /config/php/php-fpm.ini /etc/php5/fpm/php.ini

chown abc:abc /config/log/pydio /data /config/php/*

