#!/bin/sh

# Fetch kaliroot from $APPDATA/kali_in_batch/kaliroot.txt
kaliroot=$(cat "$APPDATA/kali_in_batch/kaliroot.txt")

# Check if "$APPDATA/kali_in_batch/kaliroot.txt" doesn't exist

if [ ! -f "$APPDATA/kali_in_batch/kaliroot.txt" ]; then
    kaliroot=$(cat "$APPDATA/kali_in_batch/kibroot.txt")
fi

# Create /usr/lib/file
mkdir -p $kaliroot/usr/lib/file

# Copy ./files/* to /usr/lib/file
cp -f ./files/* $kaliroot/usr/lib/file/

echo "Note: The package binary is installed to $kaliroot/usr/lib/file, which might not be in PATH if you are on a version lower than 9.12.1. Please add that to PATH in your ~/.bashrc if it isn't in PATH."
