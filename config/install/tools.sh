#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install common tools"
apt-get update -y
apt-get install -y --no-install-recommends apt-utils vim wget curl net-tools zip unzip
apt-get clean -y
apt-get autoremove -y
