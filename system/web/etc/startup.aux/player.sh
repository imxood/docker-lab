#!/bin/bash

[ -z "$VNC_PLAYER" ] && VNC_PLAYER=0

if [ $VNC_PLAYER -eq 1 ]; then
    rm /etc/supervisor/conf.d/gateone.conf
    rm /etc/supervisor/conf.d/sshd.conf
    sed -i -e "s%--vnc.*%%g" /etc/supervisor/conf.d/novnc.conf
fi
