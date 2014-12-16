#!/bin/sh -e

#this lock the screen and turn the screen off after 90s. While inactive for 5 min 
#it goes into suspended mode

i3lock -i ~/wallpaper/anon.png
sleep 90; pgrep i3lock && xset dpms force off

pgrep i3lock && sleep 300; pgrep i3lock && sudo pm-suspend
