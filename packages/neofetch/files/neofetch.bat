@echo off

setlocal enabledelayedexpansion

rem Fetch kaliroot from %APPDATA%\kali_in_batch\kaliroot.txt

set /p kaliroot=<"%APPDATA%\kali_in_batch\kaliroot.txt" >nul 2>&1

call "!kaliroot!\usr\bin\gnu-bash-wrapper.bat" "!kaliroot!\usr\lib\neofetch\neofetch"
