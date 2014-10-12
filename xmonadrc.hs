import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.ThreeColumns
import System.IO

myLayout = ThreeColMid 1 (3/100) (1/2) ||| Full

main = do
   xmonad $ defaultConfig
    { manageHook = manageDocks <+> manageHook defaultConfig
    , layoutHook = myLayout 
    , terminal    = "terminator"
    , normalBorderColor = "#aaaaaa"
    , focusedBorderColor = "#000000"
    , borderWidth = 3
    }
