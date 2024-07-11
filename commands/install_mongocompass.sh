#! /bin/bash

if [ ! -x "$(command -v mongo-compass)" ]; then
	echo "------------------------------------------"
	read -p "- Install Mongo-Compass? [Y/n] " -r reply
	echo "------------------------------------------"
	if [[ ${reply} =~ ^[Yy]$ ]]; then
		# Install prerequisite
		if [ ! -x  "$(command -v jq)" ]; then
			# Install jq
			sudo apt install -y jq
		fi
		# Get latest version
		mongocompass_latestversion=$(curl -s https://api.github.com/repos/mongodb-js/compass/releases/latest | jq -r '.tag_name' | sed 's/^v//')
		# URI
		# FIXME dpkg-deb: error: 'mongodb-compass-1.43.4-linux-x64.deb' is not a Debian format archive
		download_uri="https://downloads.mongodb.com/compass/mongodb-compass-${mongocompass_latestversion}-linux-x64.deb"
		# Download
		curl -LO ${download_uri}
		# Install (debian like)
		sudo dpkg -i mongodb-compass-${mongocompass_latestversion}-linux-x64.deb
		# Fix Broken Dependencies
		sudo apt-get install -f -y
		# Clean
		rm "./mongodb-compass-${mongocompass_latestversion}-linux-x64.deb"
		# Done
		echo "Mongo-Compass installed: mongodb-compass"
	fi
fi
