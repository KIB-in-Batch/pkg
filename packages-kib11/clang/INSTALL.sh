#!/bin/sh

powershell -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser"
powershell -Command "Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression"

powershell -Command "scoop update"
powershell -Command "scoop bucket add main"
powershell -Command "scoop install llvm"
powershell -Command "scoop reset llvm"
ls -lah "${USERPROFILE}/scoop/apps/llvm/current/"
echo "For clang to be in your path, please relaunch your entire terminal."
