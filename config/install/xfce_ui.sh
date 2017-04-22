#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install Xfce4 UI components  ---!xterm"
apt-get update -y
apt-get install -y supervisor xfce4
apt-get purge -y pm-utils xscreensaver*
apt-get clean -y
