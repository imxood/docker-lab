#!/bin/bash
set -e

[ -z "$NO_VNC_HOME" ] && NO_VNC_HOME="/usr/lib/noVNC"
## resolve_vnc_connection
VNC_IP=$(ip addr show eth0 | grep -Po 'inet \K[\d.]+')

echo -e "\n------------------ change VNC password  ------------------"
(echo $VNC_PW && echo $VNC_PW) | vncpasswd


## start vncserver and noVNC webclient
$NO_VNC_HOME/utils/launch.sh --vnc $VNC_IP:$VNC_PORT --listen $NO_VNC_PORT &
vncserver -kill :1 || rm -rfv /tmp/.X*-lock /tmp/.X11-unix || echo "remove old vnc locks to be a reattachable container"
vncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION
$HOME/x_init.sh

echo "vnc: $VNC_IP:$VNC_PORT"
echo "http: http://localhost:$NO_VNC_PORT/vnc.html?password=$VNC_PW"

tail -f $HOME/.vnc/*$DISPLAY.log