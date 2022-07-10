#!/usr/bin/env bash
#
# Update theme files

# Safer script
trap "exit" INT
set -euo pipefail

# Variables
parent=$(pwd)

# Cleanup
cleanup () {
    rm -fr $parent/build
    mkdir $parent/build
    rm -fr $parent/repo
    mkdir $parent/repo
}

# Fetch pkgbuilds
fetch () {
    cd $parent/build
    paru -G amdctl ryzenadj-git nbfc-linux
}

# Make pkgbuilds
build () {
    for dir in $parent/build/*; do
        cd $dir 
        makepkg -s
        mv $dir/*.pkg.tar.zst $parent/repo
    done
}

# Add to repo
repo () {
    for file in $parent/repo/*; do
        repo-add $parent/repo/repo.db.tar.gz $file
    done
    cd $parent
    /usr/bin/sed -i "101 s|Server.*|Server = file://$(pwd)/repo|" $parent/pacman.conf
}

# Actually do stuffs
cleanup
fetch
build
repo
