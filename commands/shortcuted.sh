#! /bin/bash -e

if [ ${#} -lt 1 ]; then
    echo "Use: shortcuted <filepath>"
    echo "Example: shortcuted ./file"
else
	filepath=$(realpath "${1}")
	if [ ! -f "${filepath}" ]; then
		echo "Error: please check the path: ${filepath}"
		exit 1
	fi
	sudo ln -s "${filepath}" "/usr/local/bin"
	echo "$(basename "${filepath}") shortcuted!"
fi
