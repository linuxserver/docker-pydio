#!/bin/bash
if [ ! -f "/config/www/pydio/index.php" ]; then
wget -O /tmp/pydio.tar.gz http://sourceforge.net/projects/ajaxplorer/files/pydio/stable-channel/6.0.8/pydio-core-6.0.8.tar.gz
cd /tmp
tar -xvf pydio.tar.gz
mv pydio-*/data/* /data/
mv pydio-* /config/www/pydio
cd /
rm -rf /tmp/* /config/www/data
sed -i -e 's@\define("AJXP_DATA_PATH",.*@\define("AJXP_DATA_PATH", "/data");@g' /config/www/pydio/conf/bootstrap_context.php
sed -i -e 's@\define("AJXP_SHARED_CACHE_DIR",.*@\define("AJXP_SHARED_CACHE_DIR", "/data/cache");@g' /config/www/pydio/conf/bootstrap_context.php
chown -R abc:abc /config/www/pydio /data
fi

