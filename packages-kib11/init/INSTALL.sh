#!/bin/sh

## INSTALL.sh for init
## To upgrade, run this in your KIB in Batch terminal:
## $ sudo kib-pkg update
## $ sudo kib-pkg upgrade init

mkdir -p /sbin
mkdir -p /usr/bin
mkdir -p /usr/include
mkdir -p /usr/lib
mkdir -p /usr/libexec
mkdir -p /usr/share
mkdir -p /sbin/internal

cp -f ./files/kib_in_batch.bat /sbin/init.bat
cp -rf ./files/bin/ /usr/bin/
cp -rf ./files/include/ /usr/include/
cp -rf ./files/lib/ /usr/lib/
cp -rf ./files/libexec/ /usr/libexec/
cp -rf ./files/share/ /usr/share/
cp -rf ./files/internal/ /sbin/internal/
