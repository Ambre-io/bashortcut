#!/bin/bash -e

if [ $# -lt 1 ]; then
    echo "Use: shortcuted <filepath1> [filepath2 ...]"
    echo "Example: shortcuted ./file1 ./file2"
    exit 1
fi

for filepath in "$@"; do
    fullpath=$(realpath "$filepath")

    if [ ! -f "$fullpath" ]; then
        echo "Error: please check the path: $fullpath"
        continue
    fi

    sudo ln -s "$fullpath" "/usr/local/bin/$(basename "$fullpath")"
    echo "$(basename "$fullpath") shortcuted!"
done
