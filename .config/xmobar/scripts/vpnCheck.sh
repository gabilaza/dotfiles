#!/bin/bash

# All "custom" vpns, are prefixed with "vpn-" as the tunnel name
VPN_NAME=$(nmcli -t -f NAME,TYPE,STATE con | awk -F: '$2=="tun" {print $1}')

if [[ "${VPN_NAME}" == "" ]] ; then
    echo "<fc=#fe8019>VPN</fc>"
elif [[ "${VPN_NAME}" =~ "tun" ]] ; then
    echo "<fc=#fabd2f>VPN</fc>"
fi
