#! /bin/bash

if [ ! -x "$(command -v nvm)" ]; then
	echo "------------------------------------------"
	read -p "- Install Nvm (Node Version Manager)? [Y/n] " -r reply
	echo "------------------------------------------"
	if [[ ${reply} =~ ^[Yy]$ ]]; then
		# Get latest version
		NVM_LATEST_VERSION=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')
		# Download and install
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_LATEST_VERSION}/install.sh | bash

		# Export
		export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

		# Activate NVM
		[ -s "${NVM_DIR}/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
		# Activate NVM Completion
		[[ -r ${NVM_DIR}/bash_completion ]] && \. ${NVM_DIR}/bash_completion
		# Done
		echo "Nvm installed: nvm"
		# Ask for Node using nvm
		echo "------------------------------------------"
		read -p "- Install Node? [Y/n] " -r reply
		echo "------------------------------------------"
		if [[ ${reply} =~ ^[Yy]$ ]]; then
			# Install
			nvm install node
			# Done
			echo "Node installed: node"
		fi
	fi
fi
