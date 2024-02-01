#!/usr/bin/env sh
xrdb -merge ~/.Xresources
exec /usr/bin/i3
exec unclutter &
