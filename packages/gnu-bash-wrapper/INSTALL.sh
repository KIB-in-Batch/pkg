#!/bin/sh

## INSTALL.sh for gnu-bash-wrapper
## To install, run this in your Kali in Batch terminal:
## $ sudo kib-pkg update
## $ sudo kib-pkg install gnu-bash-wrapper

# Check for winget

winget --version > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "Winget found"
    # Install git using winget
    winget install --accept-source-agreements -e --id Git.Git
    echo "Git installed successfully"
    # Begin copying files
    echo "Copying files..."
    rm -rf /usr/bin/gnu-bash-wrapper.bat
    export GIT_PATH="$(./files/file-copy.bat)"
    # Loop for each Msys dll file in $GIT_PATH/usr/bin
    for dll in $(find "$GIT_PATH/usr/bin" -type f -name "*.dll"); do
        # Copy the dll file to /usr/bin
        cp -f "$dll" /usr/bin/ && echo "Copied $dll to /usr/bin" || echo "Failed to copy $dll to /usr/bin" && exit 1
    done
    cp -f "$GIT_PATH/usr/bin/bash.exe" /usr/bin/gbash.exe
    if [ $? -eq 0 ]; then
        echo "Files copied successfully"
    else
        echo "Error copying files"
        exit 1
    fi
    cp -f ./files/gnu-bash-wrapper.bat /usr/bin/gnu-bash-wrapper.bat
    if [ $? -eq 0 ]; then
        echo "Files copied successfully"
    else
        echo "Error copying files"
        exit 1
    fi
else
    echo "Winget not found"
    exit 1
fi
