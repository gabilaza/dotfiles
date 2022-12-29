#!/bin/bash

VPN_NAME=$(nmcli -t -f NAME,TYPE,STATE con | awk -F: '$2=="tun" {print $1}')

case "$1" in
    --toggle)
        if [[ "${VPN_NAME}" == "" ]] ; then
            nordvpn connect RO
        elif [[ "${VPN_NAME}" =~ "tun" ]] ; then
            nordvpn disconnect
        fi
    ;;
    *)
        # All "custom" vpns, are prefixed with "vpn-" as the tunnel name

        if [[ "${VPN_NAME}" == "" ]] ; then
            echo "%{F#fe8019}"VPN"%{F-}"
        elif [[ "${VPN_NAME}" =~ "tun" ]] ; then
            echo "%{F#fabd2f}"VPN"%{F-}"
        fi
    ;;
esac
