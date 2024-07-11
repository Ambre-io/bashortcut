#! /bin/bash

if [ ! -x "$(command -v curl)" ]; then
	# Install
	sudo apt install -y curl
fi
