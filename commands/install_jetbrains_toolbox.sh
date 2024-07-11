#! /bin/bash

echo "------------------------------------------"
read -p "- Install JetBrains Toolbox? [Y/n] " -r reply
echo "------------------------------------------"
if [[ ${reply} =~ ^[Yy]$ ]]; then
	# helped by: https://github.com/nagygergo/jetbrains-toolbox-install/blob/master/jetbrains-toolbox.sh
	# Dirs
	install_dir="${HOME}/App"
	[ ! -d "${install_dir}" ] && mkdir "${install_dir}"
	name="jetbrains-toolbox"
	dir_exe="${install_dir}/${name}"
	symlink_exe="/usr/local/bin/${name}"

	# Get URI and Archive name
	archive_url=$(curl -s 'https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release' | grep -Po '"linux":.*?[^\\]",' | awk -F ':' '{print $3,":"$4}'| sed 's/[", ]//g')
	archive_filename=$(basename "${archive_url}")

	# Download the archive
	rm "./${archive_filename}" 2>/dev/null || true
	wget -q --show-progress -cO "./${archive_filename}" "${archive_url}"

	# Exctract in ~/App
	rm "${dir_exe}" 2>/dev/null || true
	tar -xzf "./${archive_filename}" -C "${install_dir}" --strip-components=1
	rm "./${archive_filename}"
	chmod +x "${dir_exe}"

	# Symlink it
	rm "${symlink_exe}" 2>/dev/null || true
	sudo ln -s "${dir_exe}" "${symlink_exe}"

	# Done
	echo "JetBrains Toolbox installed: jetbrains-toolbox"
fi
