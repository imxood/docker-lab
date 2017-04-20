#!/bin/bash
#
# novnc.sh
#

VNC_LAUNCH=/noVNC/utils/launch.sh

[ -z "$VNC_TIMEOUT" ] && VNC_TIMEOUT=0
[ -z "$VNC_RECORD" ] && VNC_RECORD=0
[ -z "$VNC_PUBLIC" ] && VNC_PUBLIC=0
[ -z "$VNC_AUTH" ] && VNC_AUTH=""

VNC_CONFIG=""

if [ $VNC_TIMEOUT -eq 1 ]; then
    VNC_CONFIG="$VNC_CONFIG --timeout=$VNC_TIMEOUT"
else
    sed -i -e "s%^\${WEBSOCKIFY} --timeout=[^ ]* %\${WEBSOCKIFY} %g" $VNC_LAUNCH
fi

if [ $VNC_PUBLIC -eq 1 ]; then
    VNC_CONFIG="$VNC_CONFIG --public "
fi

if [ -n "$VNC_AUTH" ]; then
    VNC_CONFIG="$VNC_CONFIG --auth-plugin BasicHTTPAuth --auth-source '$VNC_AUTH'"
fi

if [ $VNC_RECORD -eq 1 ]; then
    [ -z "$VNC_RECORD_FILE" ] && VNC_RECORD_FILE=/tmp/vnc.record.data
    VNC_CONFIG="$VNC_CONFIG --record $VNC_RECORD_FILE"
fi

sed -i -e "s%^\${WEBSOCKIFY}%\${WEBSOCKIFY} $VNC_CONFIG%g" $VNC_LAUNCH
