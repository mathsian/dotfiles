#!/bin/bash

xrdb -merge .Xresources

#trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --transparent true --tint 0x191970 --height 12 &

xsetroot -solid "#212121"

#nm-applet --sm-disable &

exec xmonad
