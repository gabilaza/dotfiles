#!/bin/bash

appName="mixer"
sinkTag="sink-volume"
sourceTag="source-volume"


function getSinkVolume {
    pactl get-sink-volume @DEFAULT_SINK@ | grep "Volume:" | cut -d"/" -f2 | sed 's/[^0-9]*//g'
}

function getSourceVolume {
    pactl get-source-volume @DEFAULT_SOURCE@ | grep "Volume:" | cut -d"/" -f2 | sed 's/[^0-9]*//g'
}

function isSinkMute {
    pactl get-sink-mute @DEFAULT_SINK@ | grep yes > /dev/null
}

function isSourceMute {
    pactl get-source-mute @DEFAULT_SOURCE@ | grep yes > /dev/null
}

function sendSinkNotification {
    volume=$(getSinkVolume)

    bar=$(seq -s "-" $(($volume / 3)) | sed 's/[0-9]//g')
    dunstify -a $appName -h string:x-dunst-stack-tag:$sinkTag -u low "Volume:  $bar"
}

function sendSourceNotification {
    volume=$(getSourceVolume)

    bar=$(seq -s "-" $(($volume / 3)) | sed 's/[0-9]//g')
    dunstify -a $appName -h string:x-dunst-stack-tag:$sourceTag -u low "Source:  $bar"
}

case $1 in
    sink-up)
        pactl set-sink-mute @DEFAULT_SINK@ 0 > /dev/null
        volume=$(getSinkVolume)
        if [ $volume -le 90 ] ; then
            pactl set-sink-volume @DEFAULT_SINK@ +10% > /dev/null
        fi
        sendSinkNotification
    ;;
    sink-down)
        pactl set-sink-mute @DEFAULT_SINK@ 0 > /dev/null
        pactl set-sink-volume @DEFAULT_SINK@ -10% > /dev/null
        sendSinkNotification
    ;;
    sink-mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle > /dev/null
        if isSinkMute ; then
            dunstify -a $appName -h string:x-dunst-stack-tag:$sinkTag -u low "Volume: Muted"
        else
            sendSinkNotification
        fi
    ;;
    source-up)
        pactl set-source-mute @DEFAULT_SOURCE@ 0 > /dev/null
        volume=$(getSourceVolume)
        if [ $volume -le 90 ] ; then
            pactl set-source-volume @DEFAULT_SOURCE@ +10% > /dev/null
        fi
        sendSourceNotification
    ;;
    source-down)
        pactl set-source-mute @DEFAULT_SOURCE@ 0 > /dev/null
        pactl set-source-volume @DEFAULT_SOURCE@ -10% > /dev/null
        sendSourceNotification
    ;;
    source-mute)
        pactl set-source-mute @DEFAULT_SOURCE@ toggle
        if isSourceMute ; then
            dunstify -a $appName -h string:x-dunst-stack-tag:$sourceTag -u low "Source: Muted"
        else
            sendSourceNotification
        fi
    ;;
esac
