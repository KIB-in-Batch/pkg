#!/bin/sh

## INSTALL.sh for init
## To upgrade, run this in your KIB in Batch terminal:
## $ sudo kib-pkg update
## $ sudo kib-pkg upgrade init

mkdir -p /sys/kib
cp -rfv ./files/ /sys/kib/files/
echo "Upgraded successfully. Please relaunch KIB in Batch."
