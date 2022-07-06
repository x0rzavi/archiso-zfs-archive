#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="archlinux-zfs"
iso_label="ARCH_ZFS$(date +%Y%m)"
iso_publisher="Avishek Sen <https://github.com/x0rzavi>"
iso_application="Arch Linux Live/Rescue CD with ZFS support"
iso_version="$(date +%Y.%m.%d)"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito'
           'uefi-ia32.grub.esp' 'uefi-x64.grub.esp'
           'uefi-ia32.grub.eltorito' 'uefi-x64.grub.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'zstd' '-Xcompression-level' '7' '-b' '1M')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/etc/vconsole.conf"]="0:0:644"
  ["/root"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/root/.ssh"]="0:0:0700"
  ["/root/.ssh/authorized_keys"]="0:0:0600"
  ["/usr/local/bin/Installation_guide"]="0:0:755"
  ["/var/lib/iwd"]="0:0:0700"
  ["/var/lib/iwd/x0rzavi.psk"]="0:0:0600"
)
