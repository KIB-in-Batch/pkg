#!/bin/sh

powershell -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser"
powershell -Command "Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression"

powershell -Command "scoop update"
powershell -Command "scoop uninstall llvm"
