setxkbmap -layout lv,ru -option grp:caps_toggle,grp_led:caps
xset r rate 200 25

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
exec i3
