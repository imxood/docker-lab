#!/bin/bash
set -e

## resolve_vnc_connection
VNC_IP=$(ip addr show eth0 | grep -Po 'inet \K[\d.]+')

echo -e "\n------------------ change VNC password  ------------------"
(echo $VNC_PW && echo $VNC_PW) | vncpasswd


## start vncserver and noVNC webclient
$NO_VNC_HOME/utils/launch.sh --vnc $VNC_IP:$VNC_PORT --listen $NO_VNC_PORT &
vncserver -kill :1 || rm -rfv /tmp/.X*-lock /tmp/.X11-unix || echo "remove old vnc locks to be a reattachable container"
vncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION
$HOME/wm_startup.sh

## log connect options
echo -e "\n\n------------------ VNC environment started ------------------"
echo -e "\nVNCSERVER started on DISPLAY= $DISPLAY \n\t=> connect via VNC viewer with $VNC_IP:$VNC_PORT"
echo -e "\nnoVNC HTML client started:\n\thttp://$VNC_IP:$NO_VNC_PORT/?password=...\n"

tail -f $HOME/.vnc/*$DISPLAY.log