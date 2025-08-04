#!/bin/sh

# Create /usr/lib/file
mkdir -p /usr/lib/file

# Copy ./files/* to /usr/lib/file

cp -f ./files/* /usr/lib/file/

# Make /usr/bin/file.exe a symlink to /usr/lib/file/file.exe

ln -s /usr/lib/file/file.exe /usr/bin/file.exe

if [ $? -eq 0 ]; then
    echo "Could copy files because yes"
else
    echo "Unable to create symlinks, please enable developer mode or run Kali in Batch as admin."
fi
