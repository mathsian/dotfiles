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

xmobarTitleColor = "#6c99bb"
xmobarCurrentWorkspaceColor = "#e5b567"
myNormalBorderColor  = "#9f4e85"
myFocusedBorderColor = "#6c99bb"
myLayout = dwindle ||| Circle ||| tiled ||| Mirror tiled ||| Full
  where
    tiled = smartSpacing 5 $ Tall nmaster delta ratio
    nmaster = 1
    ratio = 1/2
    delta = 3/100
    dwindle = smartSpacing 5 $ Dwindle R CW (3/2) (11/10)
main = do
        xmproc <- spawnPipe "xmobar ~/.xmobarrc"
        xmonad $ docks $ defaultConfig
                { terminal = "kitty"
                , modMask = mod4Mask
                , borderWidth = 2
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
