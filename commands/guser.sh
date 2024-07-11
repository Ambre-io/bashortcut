#!/bin/bash -e

read -p "git username: " -r NAME
read -p "git email: " -r EMAIL
read -p "Do you confirm information? (y/n) " -r REPLY
if [[ ${REPLY} =~ ^[Yy]$ ]]; then
    git config --global user.name "${NAME}"
    RESNAME="${?}"
    git config --global user.email "${EMAIL}"
    RESEMAIL=${?}
    if [[ "${RESNAME}" -eq 0 && "${RESEMAIL}" -eq 0 ]]; then
        printf "\nSuccess: new git user configured."
    else
        printf "\nError: fail to configure the new git user."
    fi
fi

printf "\n------------------------------\nCurrent setup:\n------------------------------\n"
git config --list
echo "------------------------------"
