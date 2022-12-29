#!/bin/bash

appName="brightnessDisplay"
tag="brightness"


function getBrightness {
    xbacklight -get | cut -d"." -f1
}

function sendNotification {
    level=$(getBrightness)

    bar=$(seq -s "-" $(($level / 3)) | sed 's/[0-9]//g')
    dunstify -a $appName -h string:x-dunst-stack-tag:$tag -u low "Brightness: $bar"
}


case $1 in
    up)
        xbacklight -inc 10
        sendNotification
    ;;
    down)
        xbacklight -dec 10
        sendNotification
    ;;
esac
