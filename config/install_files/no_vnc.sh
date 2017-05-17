#!/usr/bin/env bash
set -e

echo "Install noVNC - HTML5 based VNC viewer"

NO_VNC_HOME="/usr/lib/noVNC"

wget https://codeload.github.com/novnc/noVNC/zip/master -O noVNC-master.zip
unzip noVNC-master.zip
mv noVNC-master $NO_VNC_HOME
rm -f noVNC-master.zip

wget https://codeload.github.com/novnc/websockify/zip/master -O websockify-master.zip
unzip websockify-master.zip
mv websockify-master $NO_VNC_HOME/utils/websockify
rm -f websockify-master.zip