import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)
import System.IO
main = do
        xmproc <- spawnPipe "xmobar ~/.xmobarrc"
        xmonad $ docks $ defaultConfig
                { terminal = "urxvt"
                , modMask = mod4Mask
                , borderWidth = 2
                , normalBorderColor = "#cccccc"
                , focusedBorderColor = "#cd8b00"
                , manageHook = manageDocks <+> manageHook defaultConfig
                , layoutHook = avoidStruts $ layoutHook defaultConfig
                , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "hi" . shorten 50
                        }
                }
