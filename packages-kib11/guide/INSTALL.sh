#!/bin/sh

## INSTALL.sh for guide
## To install, run this in your KIB in Batch terminal:
## $ sudo kib-pkg update
## $ sudo kib-pkg install guide

mkdir -p /usr/share/guide
cp -rfv ./files/* /usr/share/guide/
