#!/bin/bash
if [ ! -f "/config/www/pydio/index.php" ]; then
curl -o /tmp/install.zip  -L https://download.pydio.com/pub/core/archives/pydio-core-7.0.2.zip 
cd /tmp || exit
unzip install.zip
mv pydio-*/data/* /data/
mv pydio-* /config/www/pydio
cd / || exit
rm -rf /tmp/* /config/www/data
chown -R abc:abc /config/www/pydio /data
fi

