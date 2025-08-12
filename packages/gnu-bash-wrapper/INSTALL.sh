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
    # Check errorlevel
    if [ $? -eq 0 ]; then
        echo "Git installed successfully"
        # Begin copying files
        echo "Copying files..."
        cp -f ./files/gnu-bash-wrapper.bat /usr/bin/gnu-bash-wrapper.bat
        if [ $? -ne 0 ]; then
            echo "Could not copy files because no"
            exit 1
        else
            echo "Could copy files"
        fi
    else
        echo "Git installation failed"
        exit 1
    fi
else
    echo "Winget not found"
    exit 1
fi
