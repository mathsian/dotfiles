#!/bin/bash

xrdb -merge .Xresources

# comp manager if you like 
xcompmgr -c -C -t-5 -l-5 -r4.2 -o.55 &

#trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --transparent true --tint 0x191970 --height 12 &

xsetroot -solid "#212121"
feh --bg-fill ~/Downloads/background-black-and-white-close-up-924002.jpg
#nm-applet --sm-disable &

exec xmonad
