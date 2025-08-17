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

rem Replace backslashes with slashes in GIT_PATH

set "GIT_PATH=!GIT_PATH:\=/!"

echo "!GIT_PATH!"
