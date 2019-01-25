#!/bin/bash
# Script for installing java11 on Ubuntu
# This is because currently (Jan, 24 2019) the apt package available
# states "openjdk-11", but installs the version 10.0.2
# It was tested (and made for) Ubuntu 18.02
echo "Downloading tarball"
wget https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz ~/Downloads/openjdk-11.0.2_linux-x64_bin.tar.gz
echo "Extracting tarball"
sudo tar xfvz ~/openjdk-11.0.2_linux-x64_bin.tar.gz --directory /usr/lib/jvm
echo "Deleting unnecessary files"
rm -f ~/openjdk-11.0.2_linux-x64_bin.tar.gz

echo "***********"
echo ""
echo "Setting java 11 as default"
sudo sh -c 'for bin in /usr/lib/jvm/jdk-11/bin/*; do update-alternatives --install /usr/bin/$(basename $bin) $(basename $bin) $bin 100; done'
sudo sh -c 'for bin in /usr/lib/jvm/jdk-11/bin/*; do update-alternatives --set $(basename $bin) $bin; done'
