#!/bin/sh

## INSTALL.sh for posix
## To upgrade, run this in your KIB in Batch terminal:
## $ sudo kib-pkg update
## $ sudo kib-pkg upgrade posix

rm -rf /usr/include
mkdir -p /usr/include
cp -rfv ./files/ /usr
find /usr/include -type f -exec unix2dos {} \;
