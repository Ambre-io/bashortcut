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
		VERSION=$(curl -s https://api.github.com/repos/mongodb-js/compass/releases/latest | jq -r '.tag_name' | sed 's/^v//')
		DEB_FILE="mongodb-compass_${VERSION}_amd64.deb"
        DOWNLOAD_URL="https://downloads.mongodb.com/compass/${DEB_FILE}"

        # Step 1: Download the MongoDB Compass .deb file
        echo "Downloading MongoDB Compass version ${VERSION}..."
        wget $DOWNLOAD_URL -O /tmp/$DEB_FILE

        # Step 2: Install the downloaded .deb package
        echo "Installing MongoDB Compass..."
        sudo dpkg -i /tmp/$DEB_FILE

        # Step 3: Fix any missing dependencies
        echo "Fixing missing dependencies..."
        sudo apt-get install -f -y

        # Step 4: Clean up
        echo "Cleaning up..."
        rm /tmp/$DEB_FILE

        # Step 5: Launch MongoDB Compass
        echo "MongoDB Compass installed. You can launch it by searching in your applications menu or by running 'mongodb-compass'."
	fi
fi
