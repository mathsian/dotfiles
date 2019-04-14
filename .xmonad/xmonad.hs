import XMonad
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)
import System.IO

xmobarTitleColor = "#22CCDD"
xmobarCurrentWorkspaceColor = "#CEFFAC"
myNormalBorderColor  = "black"
myFocusedBorderColor = "#22CCDD"

main = do
        xmproc <- spawnPipe "xmobar ~/.xmobarrc"
        xmonad $ docks $ defaultConfig
                { terminal = "kitty"
                , modMask = mod4Mask
                , borderWidth = 1
                , normalBorderColor = myNormalBorderColor
                , focusedBorderColor = myFocusedBorderColor
                , manageHook = manageDocks <+> manageHook defaultConfig
                , layoutHook = avoidStruts $ layoutHook defaultConfig
                , logHook = dynamicLogWithPP $ xmobarPP {
                    ppOutput = hPutStrLn xmproc
                  , ppTitle = xmobarColor xmobarTitleColor "" . shorten 100
                  , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
                  , ppSep = "   "
                  }
                , startupHook = setWMName "LG3D"
        }
