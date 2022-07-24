#!/bin/sh

cp mpm /usr/local/bin/mpm
sudo mkdir /usr/local/lib/mpm
cp -r ./lib/* /usr/local/lib/mpm

sudo chmod 755 /usr/local/lib/mpm/*
sudo chmod 755 /usr/local/bin/mpm

echo "for usage run: mpm --help"
