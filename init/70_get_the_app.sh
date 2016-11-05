#!/bin/bash
if [ ! -f "/config/www/pydio/index.php" ]; then
curl -o /tmp/install.zip  -L https://sourceforge.net/projects/ajaxplorer/files/pydio/stable-channel/6.4.2/pydio-core-6.4.2.zip/download
cd /tmp || exit
unzip install.zip
mv pydio-*/data/* /data/
mv pydio-* /config/www/pydio
cd / || exit
rm -rf /tmp/* /config/www/data
chown -R abc:abc /config/www/pydio /data
fi

