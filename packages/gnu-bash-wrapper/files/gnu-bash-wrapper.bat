@echo off
setlocal enabledelayedexpansion

rem Read kaliroot
set /p kaliroot=<"%APPDATA%\kali_in_batch\kaliroot.txt"
set "bash_path=%kaliroot%\usr\bin\gbash.exe"

rem Paths
set "rcfilepath=%USERPROFILE%\kali\usr\lib\gnu-bash-wrapper\rcfile.sh"
set "rcfilepath=%rcfilepath:\=/%"
set "HOME=%USERPROFILE%\kali\home\%USERNAME%"
set "HOME=%HOME:\=/%"
set "BASH_ENV=%rcfilepath%"

rem Rebuild args excluding --rcfile and its parameter
set "newargs="
set skipnext=0
for %%A in (%*) do (
    if !skipnext! equ 1 (
        echo Skipping --rcfile argument: %%A
        set skipnext=0
    ) else if /i "%%A"=="--rcfile" (
        echo Skipping --rcfile
        set skipnext=1
    ) else (
        set "newargs=!newargs! %%A"
    )
)

rem Run without the --rcfile foo part
"%bash_path%" --rcfile "%rcfilepath%" !newargs!
