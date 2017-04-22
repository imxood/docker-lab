#!/usr/bin/env bash
set -e

echo "Install TigerVNC server"
wget -q --no-check-certificate https://dl.bintray.com/tigervnc/stable/tigervnc-1.7.0.x86_64.tar.gz
tar -xzf tigervnc-1.7.0.x86_64.tar.gz --strip 1 -C /
