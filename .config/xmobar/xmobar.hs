Config {
         font        = "xft:SF Mono Regular-12"
       , bgColor     = "#282828"
       , fgColor     = "#ebdbb2"
       , alpha       = 255
       , position    = Static { xpos = 10 , ypos = 5, width = 2540, height = 26 }
       , textOffset  = 18
       , borderColor = "#585858"
       , borderWidth = 1
       , commands = [ Run Cpu
                        [ "--template", "<fc=#fabd2f>CPU</fc>: <total>%"
                        , "-L", "5"
                        , "-H", "75"
                        , "--high"  , "#fb4934"
                        , "--normal", "#b8bb26"
                        ] 10
                    , Run Alsa "default" "Master"
                        [ "--template", "<fc=#fabd2f>Vol</fc>: <volumestatus>"
                        , "--suffix"  , "True"
                        , "--"
                        , "--on", ""
                        ]
                    , Run Memory ["--template", "<fc=#fabd2f>RAM</fc>: <usedratio>%"] 10
                    , Run Com "bash"  ["/home/forest/.config/xmobar/scripts/vpnCheck.sh"] "vpn" 5
                    , Run BatteryP ["BAT0"]
                        ["--template", "<acstatus>"
                        , "-L", "20", "-H", "80"
                        , "-l", "#fb4934", "-h", "#b8bb26"
                        , "--"
                        , "-O", "<fc=#fabd2f>CHR</fc>: <left>%"
                        , "-o", "<fc=#fabd2f>BAT</fc>: <left>%"
                        , "-i", "<fc=#fabd2f>BAT</fc>: <left>%"
                        ] 5
                    , Run Date "%a %Y-%m-%d <fc=#83a598>%H:%M</fc>" "date" 10
                    , Run XMonadLog
                    ]
       , sepChar  = "%"
       , alignSep = "}{"
       , template = "  %XMonadLog% }{ %cpu% | %memory% | %vpn% | %alsa:default:Master% | %battery% | %date%  "
       }
