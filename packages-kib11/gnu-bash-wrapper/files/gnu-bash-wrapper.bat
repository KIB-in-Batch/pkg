@echo off
setlocal enabledelayedexpansion

set "kaliinusrprofile=kali"

rem Read kaliroot
if not exist "%APPDATA%\kali_in_batch\kaliroot.txt" (
    set /p kaliroot=<"%APPDATA%\kib_in_batch\kibroot.txt" >nul 2>&1
    set "kaliinusrprofile=kib"
) else (
    set /p kaliroot=<"%APPDATA%\kali_in_batch\kaliroot.txt" >nul 2>&1
) 
set "bash_path=%kaliroot%\usr\bin\gbash.exe"

rem Paths
set "rcfilepath=%USERPROFILE%\%kaliinusrprofile%\usr\lib\gnu-bash-wrapper\rcfile.sh"
set "rcfilepath=%rcfilepath:\=/%"
set "HOME=%USERPROFILE%\%kaliinusrprofile%\home\%USERNAME%"
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
