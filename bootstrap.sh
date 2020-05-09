#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

#git pull origin master;

function doTheDeed() {
    rsync \
        --exclude ".git/" \
        --exclude ".DS_STORE" \
        --exclude "bootstrap.sh" \
        --exclude "pkglists/" \
        --exclude "os-specific/" \
        -avh -I --no-perms . ~;

    source ~/.zprofile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    doTheDeed;
else
    read -p "This may overwrite existing files. Are you sure? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doTheDeed;
    fi;
fi
