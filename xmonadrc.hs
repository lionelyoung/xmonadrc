-- Allow xfceConfig
import XMonad
import XMonad.Config.Xfce
-- Helpers
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
-- Layout
import XMonad.Layout.NoBorders
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.Magnifier
import XMonad.Layout.LimitWindows
import XMonad.Layout.FixedColumn
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ThreeColumns
-- End

-- Hotkeys
-- http://xmonad.org/manpage.html
-- Mod-b toggles Xfce panel
-- Mod-q reloads xmonad.hs
-- Mod-space: Rotate through the available layout algorithms
-- Mod-shift-space: Resets the layouts on the current workspace to default

myWorkspaces = ["work","web","three","chat","media","6","7","8","9"]

main = xmonad xfceConfig {
  modMask = mod4Mask  -- Super key as Mod
, workspaces = myWorkspaces 
, layoutHook = myLayout 
, manageHook = myManageHook <+> manageHook xfceConfig
-- can also use words like red or blue
, focusedBorderColor = "#ff3333"
}

-- layouts
-- FixedColumn 1 20 x 10, where x is number of columns.
-- 170 gives an 80/80 vertical-split plus room for gutters in vim
myCode = limitWindows 3 $ magnifiercz' 1.4 $ FixedColumn 1 20 170 10
mySplit = magnifiercz' 1.3 $ Tall nmaster delta ratio
    where
        -- The default number of windows in the master pane
        nmaster = 1
        -- Percent of screen to increment by when resizing panes
        delta   = 15/100
        -- Default proportion of screen occupied by master pane
        ratio   = 60/100
myHalf = Tall 1 (25/100) (50/100)
myThree = ThreeColMid 1 (3/100) (1/2)

perWS = onWorkspace "work" ( myCode ||| Full ) $
        onWorkspace "chat"  ( myHalf ||| Mirror myHalf ||| Full ) $
        onWorkspace "web"  ( mySplit ||| Mirror mySplit ||| Full ) $
        onWorkspace "three"  ( myThree ||| Full ) $
        layoutHook defaultConfig

-- avoidStruts: show the XFCE panel
-- smartBorders: No borders on full-screen
myLayout = avoidStruts $ smartBorders $ toggleLayouts Full perWS

-- hooks
myManageHook = composeAll
 [ isFullscreen --> doFullFloat -- Fullscreen Flash video
 , className =? "Xfrun4" --> doFloat 
 , className =? "Gimp-2.8" --> doFloat 
 , className =? "VirtualBox" --> doFloat 
 , className =? "Steam" --> doFloat 
 , className =? "playonlinux" --> doFloat 
 , className =? "Keepassx" --> doFloat 
 , title =? "PlayOnLinux" --> doFloat 
 , title =? "Application Finder" --> doCenterFloat 
-- prevent notifyd from taking focus
 , className =? "Xfce4-notifyd" --> doIgnore
 ]

