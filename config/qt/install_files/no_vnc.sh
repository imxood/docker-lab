#!/usr/bin/env bash
set -e

echo "Install noVNC - HTML5 based VNC viewer"

[ -z "$NO_VNC_HOME" ] && NO_VNC_HOME="/usr/lib/noVNC"

mkdir -p $NO_VNC_HOME/utils/websockify

wget -q --no-check-certificate https://github.com/kanaka/websockify/archive/v0.8.0.tar.gz
tar -xzf v0.8.0.tar.gz --strip 1 -C $NO_VNC_HOME/utils/websockify
rm -f v0.8.0.tar.gz

chmod +x -v $NO_VNC_HOME/utils/*.sh