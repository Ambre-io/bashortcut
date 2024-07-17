#! /bin/bash

echo "------------------------------------------"
read -p "- Install DBeaver? [Y/n] " -r reply
echo "------------------------------------------"
if [[ ${reply} =~ ^[Yy]$ ]]; then
   # Update the package index
    sudo apt update

    # Install the required dependencies
    sudo apt install -y wget gpg

    # Import the DBeaver GPG key
    wget -qO - https://dbeaver.io/debs/dbeaver.gpg.key | sudo apt-key add -

    # Add the DBeaver repository
    echo "deb https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list

    # Update the package index again after adding the repository
    sudo apt update

    # Install DBeaver
    sudo apt install -y dbeaver-ce

	# Done
	echo "DBeaver is installed: dbeaver"
fi
