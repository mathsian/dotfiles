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

xmobarTitleColor = "#6c99bb"
xmobarCurrentWorkspaceColor = "#e5b567"
myNormalBorderColor  = "#9f4e85"
myFocusedBorderColor = "#6c99bb"
myLayout = dwindle ||| circle ||| horiz ||| vert ||| full
  where
    full = named "full" $ Full
    horiz = named "horiz" $ smartSpacing 1 $ Tall 1 (3/100) (1/2)
    circle = named "circle" $ Circle
    vert = named "vert" $ Mirror horiz
    dwindle = named "dwindle" $ smartSpacing 1 $ Dwindle R CW (3/2) (11/10)

main = do
        xmproc <- spawnPipe "xmobar ~/.xmobarrc"
        xmonad $ docks $ defaultConfig
                { terminal = "kitty"
                , modMask = mod4Mask
                , borderWidth = 1
                , normalBorderColor = myNormalBorderColor
                , focusedBorderColor = myFocusedBorderColor
                , manageHook = manageDocks <+> manageHook defaultConfig
                , layoutHook = avoidStruts myLayout
                , logHook = dynamicLogWithPP $ xmobarPP 
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor xmobarTitleColor "" . shorten 100
                        , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
                        , ppSep = "   "
                        }
                , startupHook = setWMName "LG3D"
                } `additionalKeysP`
                [("M-S-p", spawn "rofi -show combi")
                ]
