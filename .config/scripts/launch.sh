#!/usr/bin/env sh
killall -q polybar
COUNT=$(xrandr --query | grep " connected" | wc -l)
PRIMARY=$(xrandr --query | grep " connected" | grep "primary" | cut -d" " -f1)
OTHERS=$(xrandr --query | grep " connected" | grep -v "primary" | cut -d" " -f1)

if [ $COUNT -gt 1 ]; then
  MONITOR=$PRIMARY polybar --reload main & 
  sleep 1
  for m in $OTHERS; do
    MONITOR=$m polybar --reload sides &
  done
else
  MONITOR=$PRIMARY polybar --reload laptop &
fi

