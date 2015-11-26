#!/bin/bash
if [ ! -f "/config/www/pydio/index.php" ]; then
curl -o /tmp/install.zip  -L http://sourceforge.net/projects/ajaxplorer/files/latest/download?source=files
cd /tmp
unzip install.zip
mv pydio-*/data/* /data/
mv pydio-* /config/www/pydio
cd /
rm -rf /tmp/* /config/www/data
chown -R abc:abc /config/www/pydio /data
fi

