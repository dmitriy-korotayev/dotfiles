[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
[[ -f /usr/bin/xscreensaver ]] && /usr/bin/xscreensaver -no-splash &

exec i3 --shmlog-size=26214400
