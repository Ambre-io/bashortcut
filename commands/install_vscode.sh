#! /bin/bash

echo "------------------------------------------"
read -p "- Install Visual Studio Code? [Y/n] " -r reply
echo "------------------------------------------"
if [[ ${reply} =~ ^[Yy]$ ]]; then
    # Update the package index
    sudo apt update

    # Install the required dependencies
    sudo apt install -y software-properties-common apt-transport-https wget

    # Import the Microsoft GPG key
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -

    # Enable the Visual Studio Code repository
    sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

    # Update the package index again after adding the repository
    sudo apt update

    # Install Visual Studio Code
    sudo apt install -y code

	# Done
	echo "Visual Studio Code is installed: code"
fi
