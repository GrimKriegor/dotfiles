#!/bin/sh

# Iterate system xinit configs
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Reload Xresources
if [[ -f ~/.Xresources ]]; then
  xrdb -load ~/.Xresources
fi

# Apply keyboard mods
if [[ -f ~/.Xmodmap ]]; then
  xmodmap ~/.Xmodmap
fi

# Boot the desktop environment
exec i3
