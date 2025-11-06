#!/bin/sh

## INSTALL.sh for init
## To upgrade, run this in your KIB in Batch terminal:
## $ sudo kib-pkg update
## $ sudo kib-pkg upgrade init

mkdir -p /sys/kib
find "./files" -print0 |
while IFS= read -r -d '' f; do
    cp -rf "$f" /sys/kib/
done
