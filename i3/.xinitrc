#export DISPLAY=:0
setxkbmap -layout lv,ru -option grp:caps_toggle,grp_led:caps
xset r rate 200 25
xset b off
#xbindkeys

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

[[ -f /usr/bin/xscreensaver ]] && /usr/bin/xscreensaver -no-splash &
exec i3 --shmlog-size=26214400
