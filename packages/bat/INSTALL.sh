#!/bin/sh

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

# Push current directory to the stack

pushd .

# Cd to ./files/bat

cd ./files/bat

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

# Restore the stack

popd
