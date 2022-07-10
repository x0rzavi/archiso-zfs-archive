#!/usr/bin/env

pacman-key --init
pacman -Syyu --noconfirm

pacman-key -r DDF7DB817396A49B2A2723F7403BD972F75D9D76
pacman-key --lsign-key DDF7DB817396A49B2A2723F7403BD972F75D9D76
cat >>/etc/pacman.conf << EOF

[archzfs]
Server = https://archzfs.com/$repo/$arch
Server = http://mirror.sum7.eu/archlinux/archzfs/$repo/$arch
Server = https://mirror.biocrafting.net/archlinux/archzfs/$repo/$arch
Server = https://mirror.in.themindsmaze.com/archzfs/$repo/$arch
Server = https://zxcvfdsa.com/archzfs/$repo/$arch
EOF

pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
pacman-key --lsign-key FBA220DFC880C036
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm
cat >>/etc/pacman.conf << EOF

[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist 
EOF
