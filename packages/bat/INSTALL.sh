#!/bin/sh

## INSTALL SCRIPT FOR KALI IN BATCH BAT PACKAGE ##
# Compiles bat, a clone of cat with syntax highlighting from source and installs it.
# Meant to be used with kib-pkg, not directly here!

# Install scoop using PowerShell

which scoop > /dev/null 2>&1

if [ $? -ne 0 ]; then
    powershell -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser"
    powershell -Command "Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression"
fi

# Install packages

which cargo > /dev/null 2>&1

if [ $? -ne 0 ]; then
    scoop install rust
fi

scoop reset rust # Ensure it's in PATH

# Use powershell to extract ./files/bat.zip

powershell -Command "Expand-Archive -Path ./files/bat.zip -DestinationPath ./files/bat"

# Change to bat directory

cd ./files/bat/bat

# Compile it

cargo build --release

# Try to find where bat.exe is

bat_path=$(find . -type f -name "bat.exe" -print -quit)

if [[ -z "$bat_path" ]]; then
    echo "bat.exe not found."
    exit 1
fi

echo "Found bat.exe at: $bat_path"

# Copy bat.exe to /usr/bin

cp "$bat_path" /usr/bin/bat.exe
