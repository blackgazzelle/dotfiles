#!/usr/bin/env /bin/bash
pasystray &
nm-applet &
blueman-applet &
nextcloud &
if [ -x "$(command -v foo)" ]; then
    polychromatic-tray-applet &
    polychromatic-cli -o static -c FF0000
fi
