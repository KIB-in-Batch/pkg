@echo off

setlocal enabledelayedexpansion

for /f "tokens=2,*" %%a in ('reg query "HKCU\Software\GitForWindows" /v InstallPath 2^>nul') do set GIT_PATH=%%b
if not defined GIT_PATH (
    for /f "tokens=2,*" %%a in ('reg query "HKLM\Software\GitForWindows" /v InstallPath 2^>nul') do set GIT_PATH=%%b
)
if not defined GIT_PATH (
    echo Git Bash not found. Please reinstall this package.
    exit /b 1
)

set "bash_path=!GIT_PATH!\bin\bash.exe"

set "rcfilepath=%USERPROFILE%/kali/etc/.kibenv"

rem Replace backslashes with slashes in rcfilepath

set "rcfilepath=!rcfilepath:\=/!"

"!bash_path!" --rcfile !rcfilepath! %*
