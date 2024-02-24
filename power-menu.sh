#!/usr/bin/env bash

op=$( echo -e " Poweroff\n Reboot\n Suspend\n Lock\n Logout" | fuzzel -i --dmenu | awk '{print tolower($2)}' )

case $op in 
        poweroff)
                ;&
        reboot)
                ;&
        suspend)
                systemctl $op
                ;;
        lock)
		swaylock
                ;;
        logout)
                swaymsg exit
                ;;
esac

# options="Power Off\nRestart\nSleep\nLog Out"

# chosen=$(echo -e $options | wofi --dmenu --lines 4)

# case $chosen in
#     'Power Off')
#         systemctl poweroff
#         ;;
#     'Restart')
#         systemctl reboot
#         ;;
#     'Sleep')
#         systemctl suspend
#         ;;
#     'Log Out')
#         swaymsg exit
#         ;;
# esac
