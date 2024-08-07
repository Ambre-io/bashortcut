#! /bin/bash

askexe() {
	local question="$1"
	local command="$2"

	echo "------------------------------------------"
	read -p "$question [Y/n] " -r reply
	echo "------------------------------------------"
	if [[ ${reply} =~ ^[Yy]$ ]]; then
		eval "$command"
	fi
}

alias askexe="askexe"
