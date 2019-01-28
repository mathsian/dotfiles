import XMonad
import XMonad.Config.Gnome
import XMonad.Layout.Spiral
import XMonad.Hooks.ManageDocks

myLayout = spiral (3/4) ||| Full ||| tiled ||| Mirror tiled
  where
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 5/8
    delta = 1/100
myFocusedBorderColor = "#A7DBD8"

main = xmonad $ gnomeConfig
  {layoutHook = avoidStruts (myLayout),
   focusedBorderColor = myFocusedBorderColor}
