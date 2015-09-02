#!/bin/bash
if [ ! -f "/config/www/pydio/index.php" ]; then
wget -O /tmp/pydio.tar.gz http://sourceforge.net/projects/ajaxplorer/files/pydio/stable-channel/6.0.8/pydio-core-6.0.8.tar.gz
cd /tmp
tar -xvf pydio.tar.gz
mv pydio-*/data/* /data/
mv pydio-* /config/www/pydio
cd /
rm -rf /tmp/* /config/www/data
chown -R abc:abc /config/www/pydio /data
fi

