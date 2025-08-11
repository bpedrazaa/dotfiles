#!/bin/bash

export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus

# Fixed ID for low battery notifications (so they replace each other)
BATTERY_NOTIFICATION_ID=100

BATTERY="BAT1"
CAPACITY=$(cat /sys/class/power_supply/$BATTERY/capacity)
STATUS=$(cat /sys/class/power_supply/$BATTERY/status)

if [[ $CAPACITY -le 20 && $STATUS == "Discharging" ]]; then
  dunstify -u critical --replace=$BATTERY_NOTIFICATION_ID "Low Battery " "$CAPACITY%"
fi
