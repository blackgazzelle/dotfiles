#!/usr/bin/env /bin/bash
nm-applet &
blueman-applet &
nextcloud &
if [ -x "$(command -v polychromatic-tray-applet-cli)" ]; then
    polychromatic-tray-applet &
fi
