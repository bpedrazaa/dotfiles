~/scripts/configure_monitors.sh # If the setup has two monitors
udiskie -ant &
birdtray &
~/scripts/startup/dwm/bar.sh &
picom -b &
feh --no-fehbg --bg-scale '' # Set wallpaper here instead of using .fehbg
exec ~/scripts/startup/dwm/startdwm
