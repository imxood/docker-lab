#!/bin/bash
set -e



VNC_IP=$(ip addr show eth0 | grep -Po 'inet \K[\d.]+')
[ -z "$VNC_PORT" ] && VNC_PORT=5901
[ -z "$NO_VNC_PORT" ] && NO_VNC_PORT=6901

ROW="command=/usr/lib/noVNC/utils/launch.sh --vnc $VNC_IP:$VNC_PORT --listen $NO_VNC_PORT"

sed -i "s/^command=.*$/$ROW/"

vncserver -kill :1 || rm -rfv /tmp/.X*-lock /tmp/.X11-unix || echo "remove old vnc locks to be a reattachable container"

nl /etc/supervisor/conf.d/novnc.conf
