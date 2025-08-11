#!/bin/sh

# Create /usr/lib/file
mkdir -p /usr/lib/file

# Copy ./files/* to /usr/lib/file
cp -f ./files/* /usr/lib/file/

# Fetch kaliroot from $APPDATA/kali_in_batch/kaliroot.txt
kaliroot=$(cat "$APPDATA/kali_in_batch/kaliroot.txt")

# Define the path to add
new_path="$USERPROFILE/kali/usr/lib/file"

# Check if new_path is already in PATH
case ":$PATH:" in
  *":$new_path:"*) 
    ;;
  *)
    echo "export PATH=\"$new_path:\$PATH\"" >> ~/.bashrc
    ;;
esac

echo "For the package to work, please source .bashrc to add the path to your PATH variable."
