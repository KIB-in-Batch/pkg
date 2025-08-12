command_not_found_handle() {
    "$1.bat" "${@:2}"
    if [ $? -ne 0 ]; then
        busybox "$1" "${@:2}"
        if [ $? -ne 0 ]; then
            echo "Command not found: $1"
            exit 127
        fi
    fi
}

kibenv="$USERPROFILE/kali/etc/.kibenv"

source "$kibenv"
