#!/bin/bash

DEFAULT_SCREEN_SIZE="1024x768"
[ -z "$SCREEN_SIZE" ] && SCREEN_SIZE=$DEFAULT_SCREEN_SIZE

echo "SCREEN_SIZE: $SCREEN_SIZE"

[ "$SCREEN_SIZE" != "$DEFAULT_SCREEN_SIZE" ] \
    && sed -i -e "s/$DEFAULT_SCREEN_SIZE/$SCREEN_SIZE/g" /etc/supervisor/conf.d/x11vnc.conf
