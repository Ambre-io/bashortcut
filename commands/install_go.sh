#! /bin/bash

echo "------------------------------------------"
read -p "- Install Go (lang)? [Y/n] " -r reply
echo "------------------------------------------"
if [[ ${reply} =~ ^[Yy]$ ]]; then
	# Get latest version
	go_version=$(curl https://go.dev/VERSION?m=text | head -n1)
	# Download archive
	archive_filename="${go_version}.linux-amd64.tar.gz"
	wget "https://dl.google.com/go/${archive_filename}"
	# Clean older if exists
	sudo rm -rf /usr/local/go
	# Exctract
	sudo tar -C /usr/local -xzf "./${archive_filename}"
	rm "./${archive_filename}"
	# Export (also done in bsht/profile.sh)
	export PATH=$PATH:/usr/local/go/bin
	# Done
	echo "Go installed: go"
fi
