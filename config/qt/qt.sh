#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

#echo "${QTSHA} /tmp/qt/installer.run" | shasum -a 256 -c
chmod +x $HOME/installer.run
xvfb-run $HOME/installer.run --script $HOME/script.qs
