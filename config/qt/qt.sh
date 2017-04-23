#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

# xvfb give a command `xvfb-run`,virtual X server
apt-get install -y make gcc g++ build-essential libgl1-mesa-dev xvfb
apt-get clean -y

chmod +x $HOME/installer.run
xvfb-run $HOME/installer.run --script $HOME/script.qs
rm -f $HOME/installer.run
rm -f $HOME/script.qs