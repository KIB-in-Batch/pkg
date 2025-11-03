command_not_found_handle() {
    if command -v "$1.bat" >/dev/null 2>&1; then
        "$1.bat" "${@:2}"
    else
        echo "$1: command not found"
        return 127
    fi
}

kibenv="$USERPROFILE/kali/etc/.kibenv"

# Check if kibenv doesn't exist

if [ ! -f "$kibenv" ]; then
    kibenv="$USERPROFILE/kib/etc/.kibenv"
fi

source "$kibenv"
