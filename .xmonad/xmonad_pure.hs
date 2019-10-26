import XMonad
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)
import System.IO
import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Layout.Spacing
import XMonad.Layout.Circle
import XMonad.Layout.Dwindle
import XMonad.Layout.Named
import XMonad.Layout.NoBorders

xmobarTitleColor = "#6c99bb"
xmobarCurrentWorkspaceColor = xmobarTitleColor 
myFocusedBorderColor  = xmobarTitleColor 
myNormalBorderColor = "#7e8e50"
myLayout = dwindle ||| circle ||| horiz ||| vert ||| full
  where
    full = named "full" $ Full
    horiz = named "horiz" $ Tall 1 (3/100) (1/2)
    circle = named "circle" $ noBorders $ Circle
    vert = named "vert" $ Mirror horiz
    dwindle = named "dwindle" $ smartSpacing 5 $Dwindle R CW (3/2) (11/10)

main = do
        spawn "feh --bg-scale ~/wallpaper.jpg"
        xmproc <- spawnPipe "xmobar ~/.xmobarrc"
        xmonad $ docks $ defaultConfig
                { terminal = "kitty"
                , modMask = mod4Mask
                , borderWidth = 2
                , normalBorderColor = myNormalBorderColor
                , focusedBorderColor = myFocusedBorderColor
                , manageHook = manageDocks <+> manageHook defaultConfig
                , layoutHook = smartBorders $ avoidStruts myLayout
                , logHook = dynamicLogWithPP $ xmobarPP 
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor xmobarTitleColor "" . shorten 100
                        , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
                        , ppSep = "   "
                        }
                , startupHook = setWMName "LG3D"
                } `additionalKeysP`
                [("M-S-p", spawn "rofi -show combi")
                ,("<XF86AudioMute>", spawn "amixer set Master 1+ toggle")
                ,("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+")
                ,("<XF86AudioLowerVolume>", spawn "amixer set Master 5%-")
                ]
