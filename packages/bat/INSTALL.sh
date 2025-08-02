#!/bin/sh

# Install scoop using PowerShell

which scoop > /dev/null 2>&1

if [ $? -ne 0 ]; then
    powershell -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser"
    powershell -Command "Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression"
fi

# Install packages

scoop install rust # We will compile a rust code

# Push the current directory to the stack

pushd .

# Cd to ./files/bat

cd ./files/bat

# Compile

cargo build --release

# Go back to the pushed directory

popd

# Copy ./files/bat/target/bat.exe to /usr/bin/bat.exe

cp ./files/bat/target/bat.exe /usr/bin/bat.exe
