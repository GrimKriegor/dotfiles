#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

if [[ -f ~/.Xresources ]]; then
  xrdb -load ~/.Xresources
fi

if [[ -f ~/.Xmodmap ]]; then
  xmodmap ~/.Xmodmap
fi

exec i3
#exec startxfce4
