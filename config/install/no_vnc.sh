#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install noVNC - HTML5 based VNC viewer"

mkdir -p $NO_VNC_HOME/utils/websockify

wget -q --no-check-certificate https://github.com/novnc/noVNC/archive/master.zip
unzip -d $NO_VNC_HOME master.zip
rm -f master.zip

cp -r $NO_VNC_HOME/noVNC-master/* $NO_VNC_HOME
rm -rf noVNC-master

wget -q --no-check-certificate https://github.com/kanaka/websockify/archive/v0.8.0.tar.gz
tar -xzf v0.8.0.tar.gz --strip 1 -C $NO_VNC_HOME/utils/websockify
rm -f v0.8.0.tar.gz

chmod +x -v $NO_VNC_HOME/utils/*.sh

## create index.html to forward automatically to `vnc_auto.html`
ln -s $NO_VNC_HOME/vnc_auto.html $NO_VNC_HOME/index.html