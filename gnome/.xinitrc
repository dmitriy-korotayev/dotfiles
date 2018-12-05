[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
[[ -f /usr/bin/xscreensaver ]] && /usr/bin/xscreensaver -no-splash &

dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

xset -b
xset r rate 200 25
setxkbmap -layout lv,ru -option grp:caps_toggle,grp_led:caps

xset s 0 0 0
xset s noblank
xset s off
xset dpms 0 0 0
xset -dpms

exec i3 --shmlog-size=26214400 > /tmp/i3log-$(date +'%F-%k-%M-%S') 2>&1
