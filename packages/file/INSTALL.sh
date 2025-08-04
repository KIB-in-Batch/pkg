#!/bin/sh

# Create /usr/lib/file
mkdir -p /usr/lib/file

# Copy ./files/* to /usr/lib/file

cp -f ./files/* /usr/lib/file/

# Fetch kaliroot from $APPDATA/kali_in_batch/kaliroot.txt

kaliroot=$(cat $APPDATA/kali_in_batch/kaliroot.txt)

# Add that to .bashrc

echo "export PATH=\"\$USERPROFILE/kali/usr/lib/file:\$PATH\"" >> ~/.bashrc

echo "For the package to work, please source .bashrc to add the path to your PATH variable."
