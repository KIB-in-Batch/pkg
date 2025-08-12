@echo off

setlocal enabledelayedexpansion

set /p kaliroot=<"%APPDATA%\kali_in_batch\kaliroot.txt"

set "bash_path=!kaliroot!\usr\bin\gbash.exe"

set "rcfilepath=%USERPROFILE%/kali/etc/.kibenv"

rem Replace backslashes with slashes in rcfilepath

set "rcfilepath=!rcfilepath:\=/!"

"!bash_path!" --rcfile !rcfilepath! %*
