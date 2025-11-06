#!/bin/sh

## INSTALL.sh for init
## To upgrade, run this in your KIB in Batch terminal:
## $ sudo kib-pkg update
## $ sudo kib-pkg upgrade init

mkdir -p /sys/kib
cp -rf ./files/ /sys/kib/files/
