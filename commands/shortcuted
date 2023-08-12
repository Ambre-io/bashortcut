#! /bin/bash -e

if [ ${#} -lt 1 ]; then
	echo "Use: shortcuted <complete path file>"
	echo "Example: shortcuted ${HOME}/path/file"
else
	FILEPATH="${1}"
	if [ ! -f "${FILEPATH}" ]; then
		echo "Error: please check the path: ${FILEPATH}"
		exit 1
	fi

	sudo ln -s "${FILEPATH}" "/usr/local/bin"

fi
