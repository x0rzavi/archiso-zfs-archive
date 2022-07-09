#!/usr/bin/env bash

# Author: https://github.com/x0rzavi
# Description: Launch sway
# Dependencies: sway
# Derived: https://blog.realogs.in/getting-secrets-to-work-with-sway/
# Derived: https://github.com/uditkarode/dots/blob/master/scripts/swaylaunch

# setup XDG vars for apps that might need it
export XDG_CURRENT_DESKTOP=sway

# ask QT to use Wayland
export QT_QPA_PLATFORM=wayland

# Launch sway
sway
