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
    rm -fr $parent/Themes
    rm -fr $parent/airootfs/etc/skel/.local/share/icons
    rm -fr $parent/airootfs/etc/skel/.local/share/themes
    rm -fr $parent/airootfs/etc/skel/.config/gtk-4.0
    echo -e "Cleanup done!"
}

# Mkdirs
mkdirs () {
    mkdir -p $parent/Themes
    mkdir -p $parent/airootfs/etc/skel/.local/share/icons
    mkdir -p $parent/airootfs/etc/skel/.local/share/themes
    mkdir -p $parent/airootfs/etc/skel/.config/gtk-4.0
    echo -e "Making dirs done!"
}

# Clone
clone () {
    git clone https://github.com/vinceliuice/Colloid-gtk-theme.git --depth=1 --quiet $parent/Themes/gtk
    git clone https://github.com/vinceliuice/Fluent-icon-theme.git --depth=1 --quiet $parent/Themes/cursor
    echo -e "Git cloning done!\n"
}

# Install GTK
install_gtk () {
    cd $parent/Themes/gtk && ./install.sh --tweaks rimless --dest $parent/airootfs/etc/skel/.local/share/themes
    cp $parent/airootfs/etc/skel/.local/share/themes/Colloid-Dark/gtk-4.0/* $parent/airootfs/etc/skel/.config/gtk-4.0/ -r
    echo -e "\nGTK theme installed!\n"
}

# Install cursors
install_cursors () {
    /usr/bin/sed -i 's/DEST_DIR\=\"\$HOME\/\.local\/share\/icons\"/DEST_DIR\=\"$parent\/airootfs\/etc\/skel\/\.local\/share\/icons\"/' $parent/Themes/cursor/cursors/install.sh
    cd $parent/Themes/cursor/cursors && source ./install.sh
    echo -e "\nCursor theme installed!\n"
}

cleanup
mkdirs
clone
install_gtk
install_cursors
