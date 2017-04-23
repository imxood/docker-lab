#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

apt-get install -y build-essential libgl1-mesa-dev

apt-get clean -y

#echo "${QTSHA} /tmp/qt/installer.run" | shasum -a 256 -c
chmod +x $HOME/installer.run
xvfb-run $HOME/installer.run --script $HOME/script.qs
rm -f $HOME/installer.run
rm -f $HOME/script.qs