#!/bin/sh

## INSTALL.sh for init
## To upgrade, run this in your KIB in Batch terminal:
## $ sudo kib-pkg update
## $ sudo kib-pkg upgrade init

rm -rf /sys/kib
mkdir -p /sys/kib
cp -rfv ./files/ /sys/kib/files/
find /sys/kib/files -type f -exec unix2dos {} \;
echo "Upgraded successfully. Please relaunch KIB in Batch."
