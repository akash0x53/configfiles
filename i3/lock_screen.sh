#!/bin/sh -e

#this lock the screen and turn the screen off after 90s. While inactive for 5 min 
#it goes into suspended mode

#i3lock -i ~/wallpaper/anon.png
#sleep 90; pgrep i3lock && xset dpms force off

#pgrep i3lock && sleep 300; pgrep i3lock && sudo pm-suspend
take_photo(){
	streamer -s 1024x768 -j 100 -f jpeg -o "/home/akash/Pictures/who_logged_in/That_was_on_$(date +%Y-%m-%d_%H-%M).jpeg"
}
trap take_photo EXIT
scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
#[[ -f $1 ]] && convert /tmp/screen.png $1 -gravity center -composite -matte /tmp/screen.png
#dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop
i3lock -f -n -u -i /tmp/screen.png -w /home/akash/.lol.png
rm /tmp/screen.png
