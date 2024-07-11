#! /bin/bash

if [ ! -x "$(command -v docker)" ]; then
	echo "------------------------------------------"
	read -p "- Install Docker? [Y/n] " -r reply
	echo "------------------------------------------"
	if [[ ${reply} =~ ^[Yy]$ ]]; then

		# Add Docker's official GPG key
		echo "Docker Engine repository preparation & installation"
		sudo apt-get install ca-certificates curl gnupg
		sudo mkdir -m 0755 -p /etc/apt/keyrings
		sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
		sudo chmod a+r /etc/apt/keyrings/docker.asc

		# Add the repository to Apt sources
		echo \
			"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
			$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
			sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

		if { sudo apt-get update 2>&1 || echo E: update failed; } | grep -q '^[WE]:'; then
		    sudo chmod a+r /etc/apt/keyrings/docker.gpg
		    sudo apt-get update
		fi
		# Install
		sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
		sudo usermod -aG docker "${USER}"
		# Done
		echo "Docker installed: docker"
	fi
fi
