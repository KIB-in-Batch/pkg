#!/bin/sh

## INSTALL.sh for neofetch
## To install, run this in your KIB in Batch terminal:
## $ sudo kib-pkg update
## $ sudo kib-pkg install neofetch

cp -f ./files/neofetch.bat /usr/bin/neofetch.bat
mkdir -p /usr/lib/neofetch
cp -f ./files/neofetch /usr/lib/neofetch/neofetch
