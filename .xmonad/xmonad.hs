import XMonad
import XMonad.Config.Gnome
import XMonad.Layout.Spiral
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName

myLayout = spiral (3/4) ||| Full ||| tiled ||| Mirror tiled
  where
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 5/8
    delta = 1/100
myFocusedBorderColor = "#A7DBD8"

myStartupHook = do
        setWMName "LG3D"

main = xmonad $ gnomeConfig
        {layoutHook = avoidStruts myLayout,
        startupHook = myStartupHook,
        focusedBorderColor = myFocusedBorderColor}
