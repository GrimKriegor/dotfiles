#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

for i in $(polybar -m | awk -F: '{print $1}'); do
  echo -e "Monitor: $i"
  export MONITOR="$i"
  polybar top -c ~/.config/polybar/config &
done

feh --bg-scale ~/.config/wall.jpg

echo "Bars launched..."
