#!/usr/bin/env /bin/bash

# define associative array
typeset -A mode 
# And its content:
mode=(
  [Desktop]="wlr-randr --output DP-1 --on --mode 2560x1440@239.761Hz --pos 1920,0 --scale 1 && wlr-randr --output DP-2 --on --mode 1920x1080@60Hz --pos 4480,0 --scale 1 && wlr-randr --output HDMI-A-2 --on --mode 1920x1080@60Hz --pos 0,0 --scale 1"
  [Test Mode]="wlr-randr --output DP-2 --off && wlr-randr --output HDMI-A-2 --off"
  [Cancel]=""
)

mode_nrows=${#mode[@]}

selected="$(printf '%s\n' "${!mode[@]}" | sort | wofi -d -p "Monitor setup" -i -L 5 -w 1)"
swaymsg -q "exec --no-startup-id '${mode[${selected}]}'"
