#!/usr/bin/env bash 

COLORSCHEME=doom-one

### AUTOSTART PROGRAMS ###

if systemd-detect-virt --quiet; then
    lxsession &
    sleep 1
    killall picom
    xrandr -s 1920x1080 &
else
    lxsession &
fi

dunst -conf "$HOME"/.config/dunst/"$COLORSCHEME" &
nm-applet &
conky -c "$HOME"/.config/conky/qtile/01/"$COLORSCHEME".conf || echo "Couldn't start conky."
sleep 1
yes | /usr/bin/emacs --daemon &

# Wallpapers
feh --recursive --bg-fill --randomize ~/.wallpapers
