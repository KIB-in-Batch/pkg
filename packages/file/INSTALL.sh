#!/bin/sh

# Create /usr/lib/file
mkdir -p /usr/lib/file

# Copy ./files/* to /usr/lib/file

cp -f ./files/* /usr/lib/file/

# Fetch kaliroot from $APPDATA/kali_in_batch/kaliroot.txt

kaliroot=$(cat $APPDATA/kali_in_batch/kaliroot.txt)

# Add $kaliroot/usr/lib/file to PATH

export PATH="$kaliroot/usr/lib/file:$PATH"

# Add that to .bashrc

echo "export PATH=\"$kaliroot/usr/lib/file:$PATH\"" >> ~/.bashrc
