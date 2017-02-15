[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
[[ -f /usr/bin/xscreensaver ]] && /usr/bin/xscreensaver -no-splash &

exec i3 --shmlog-size=26214400 > /tmp/i3log-$(date +'%F-%k-%M-%S') 2>&1
