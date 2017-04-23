#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install common tools"
apt-get update -y
apt-get install -y --no-install-recommends vim wget curl net-tools zip unzip gcc g++ make xvfb
apt-get clean -y

#iproute2