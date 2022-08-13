#!/bin/env dash

# Description: Update theme files
# Dependencies: sassc, gtk-engine-murrine, gnome-themes-extra

# Safer script
set -o errexit
set -o nounset
trap "exit" INT

# Variables
parent=$(pwd)

# Cleanup
cleanup () {
    rm -fr "${parent}"/Themes && \
    rm -fr "${parent}"/airootfs/etc/skel/.local/share/icons && \
    rm -fr "${parent}"/airootfs/etc/skel/.local/share/themes && \
    rm -fr "${parent}"/airootfs/etc/skel/.config/gtk-4.0 && \
    printf '%s\n' 'Cleanup done!'
}

# Mkdirs
mkdirs () {
    mkdir -p "${parent}"/Themes && \
    mkdir -p "${parent}"/airootfs/etc/skel/.local/share/icons && \
    mkdir -p "${parent}"/airootfs/etc/skel/.local/share/themes && \
    printf '%s\n' 'Making dirs done!'
}

# Clone
clone () {
    git clone https://github.com/vinceliuice/Colloid-gtk-theme.git --depth=1 --quiet "${parent}"/Themes/gtk && \
    git clone https://github.com/vinceliuice/Colloid-icon-theme.git --depth=1 --quiet "${parent}"/Themes/cursor && \
    printf '%s\n' 'Git cloning done!'
}

# Install GTK
install_gtk () {
    cd "${parent}"/Themes/gtk && \
    sed -i '630s|&& link_theme||' install.sh && \
    ./install.sh --tweaks rimless --dest "${parent}"/airootfs/etc/skel/.local/share/themes && \
    cp -r "${parent}"/airootfs/etc/skel/.local/share/themes/Colloid-Dark/gtk-4.0 "${parent}"/airootfs/etc/skel/.config/gtk-4.0 && \
    printf '\n%s\n' 'GTK + libadwaita theme installed!'
}

# Install cursors
install_cursors () {
    cd "${parent}"/Themes/cursor/cursors && \
    sed -i "11s|\$HOME|${parent}/airootfs/etc/skel|" install.sh && \
    ./install.sh && \
    printf '\n%s\n' 'Cursor theme installed!'
}

cleanup
mkdirs
clone
install_gtk
install_cursors
