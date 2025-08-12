@echo off

setlocal enabledelayedexpansion

set /p kaliroot=<"%APPDATA%\kali_in_batch\kaliroot.txt"

set "bash_path=!kaliroot!\usr\bin\gbash.exe"

set "rcfilepath=%USERPROFILE%/kali/usr/lib/gnu-bash-wrapper/rcfile.sh"

rem Replace backslashes with slashes in rcfilepath

set "rcfilepath=!rcfilepath:\=/!"

set "HOME=%USERPROFILE%/kali/home/%USERNAME%"

rem Replace backslashes with slashes in HOME

set "HOME=!HOME:\=/!"

set "BASH_ENV=!rcfilepath!"

"!bash_path!" --rcfile "!rcfilepath!" %*
