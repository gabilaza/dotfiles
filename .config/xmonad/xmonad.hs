import XMonad
import Data.Monoid
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- Xmobar
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

-- Manage
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks

-- Windows
import XMonad.Actions.WithAll
import XMonad.Hooks.CurrentWorkspaceOnTop
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Actions.CycleWS

-- Layout
import XMonad.Layout.GridVariants
import XMonad.Layout.Fullscreen
import XMonad.Layout.Spacing

-- Utilities
import Graphics.X11.ExtraTypes.XF86
import XMonad.Util.SpawnOnce


-- The preferred programs
myTerminal :: String
myTerminal = "kitty"


-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses  = False

-- Width of the window border in pixels.
myBorderWidth   = 3

-- modMask
myModMask       = mod4Mask

-- Workspaces
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#585858"
myFocusedBorderColor = "#fe8019"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf )

    -- launch rofi
    , ((modm,               xK_p     ), spawn "~/.config/rofi/scripts/launcher.sh" )

    -- close focused window
    , ((modm,               xK_q     ), kill )

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown )

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown )

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move window to master
    , ((modm,               xK_f     ), windows W.shiftMaster  )

    -- Un-float all floating windows on the current workspace
    , ((modm,               xK_space ), sinkAll )

    -- Quit xmonad
    , ((modm .|. shiftMask,   xK_q   ), io (exitWith ExitSuccess) )

    -- Restart xmonad
    , ((modm .|. shiftMask,   xK_r   ), spawn "xmonad --recompile; xmonad --restart" )

    -- Spotify
    , ((modm,               xK_m       ), spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause" )
    , ((modm,               xK_comma   ), spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous"  )
    , ((modm,               xK_period  ), spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next"      )

    -- Dunst
    , ((modm,               xK_o       ), spawn "dunstctl close"       )
    , ((modm,               xK_n       ), spawn "dunstctl history-pop" )

    -- Print
    , ((0,    xK_Print                 ), spawn "scrot ~/screenshots/%Y-%m-%d-%T-screenshot.png"    )
    , ((modm, xK_Print                 ), spawn "scrot -s ~/screenshots/%Y-%m-%d-%T-screenshot.png" )

    -- i3lock
    , ((modm, xK_u                     ), spawn "i3lock -u --color=#282828" )

    -- Audio
    , ((0,    xF86XK_AudioRaiseVolume  ), spawn "~/.config/i3/control/mixer.sh sink-up"     )
    , ((0,    xF86XK_AudioLowerVolume  ), spawn "~/.config/i3/control/mixer.sh sink-down"   )
    , ((0,    xF86XK_AudioMute         ), spawn "~/.config/i3/control/mixer.sh sink-mute"   )
    , ((0,    xF86XK_AudioMicMute      ), spawn "~/.config/i3/control/mixer.sh source-mute" )
    , ((modm,    xK_a      ), spawn "~/.config/i3/control/mixer.sh sink-up"     )
    , ((modm,    xK_z      ), spawn "~/.config/i3/control/mixer.sh sink-down"   )
    , ((modm,    xK_x      ), spawn "~/.config/i3/control/mixer.sh sink-mute"   )
    , ((modm,    xK_d      ), spawn "~/.config/i3/control/mixer.sh source-up"   )
    , ((modm,    xK_c      ), spawn "~/.config/i3/control/mixer.sh source-down" )
    , ((modm,    xK_s      ), spawn "~/.config/i3/control/mixer.sh source-mute" )

    -- Brightness
    , ((0,    xF86XK_MonBrightnessUp   ), spawn "~/.config/i3/control/brightness.sh up"   )
    , ((0,    xF86XK_MonBrightnessDown ), spawn "~/.config/i3/control/brightness.sh down" )

    -- Workspace
    , ((modm, xK_bracketright               ), nextWS)
    , ((modm, xK_bracketleft                ), prevWS)
    , ((modm .|. mod1Mask, xK_bracketright ), shiftToNext)
    , ((modm .|. mod1Mask, xK_bracketleft  ), shiftToPrev)

    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.


myLayout = avoidStruts ( TallGrid 1 1 (11/20) (16/10) (3/100))

------------------------------------------------------------------------
-- Window rules:
--myManageHook = composeAll
--    [ className =? "MPlayer"        --> doCenterFloat
--    , className =? "Gimp"           --> doCenterFloat
--    , className =? "kitty"          --> doCenterFloat
--    , className =? "firefox"        --> doCenterFloat
--    , className =? "discord"        --> doCenterFloat
--    , className =? "spotify"        --> doCenterFloat
--    , className =? "CollaborativeWorkflow"  --> doCenterFloat
--    , className =? "tk"             --> doCenterFloat
--    , className =? "Tk"             --> doCenterFloat
--    , resource  =? "desktop_window" --> doIgnore      ]
--    --, resource  =? "kdesktop"       --> doIgnore ]
myManageHook = composeAll
    []

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = currentWorkspaceOnTop

mySB = statusBarProp "xmobar" (pure myPP)

myPP = xmobarPP
    { ppCurrent = xmobarColor "#fabd2f" "" . wrap "<box type=Bottom width=2> " " </box>"
    , ppHidden  = pad
    , ppUrgent  = xmobarColor "#fabd2f" "#fb4934" . wrap " " " "
    , ppSep     = ""
    , ppWsSep   = ""
    , ppTitle   = xmobarColor "#b8bb26" "" . pad
    , ppLayout  = xmobarColor "#d3869b" ""
    }

------------------------------------------------------------------------
-- Startup hook
myStartupHook :: X ()
myStartupHook = do
    spawn "xsetroot -cursor_name left_ptr"
    spawn "picom --config ~/.config/picom/picom.conf"
    spawn "feh --randomize --bg-scale ~/wallpapers/*"
    spawn "~/.config/polybar/scripts/polybar.sh"
    --spawnOnce "polybar -c ~/.config/polybar/config.ini"
    spawnOnce "xbacklight -set 25"
    setWMName "LG3D"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
--main = xmonad $ ewmhFullscreen . ewmh $ withEasySB mySB defToggleStrutsKey . docks $ fullscreenSupportBorder $ defaults
main = xmonad $ ewmhFullscreen . ewmh $ docks $ fullscreenSupportBorder $ defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- my stuff
        terminal           = myTerminal,
      -- simple stuff
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = spacingRaw False (Border 5 5 5 5) True (Border 5 5 5 5) True $ myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }

