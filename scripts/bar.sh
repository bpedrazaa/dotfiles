#! /bin/bash

# Change accordingly
WIFI_INTERFACE=""
ETH_INTERFACE=""
BATTERY=""

get_battery() {
  # Check the battery information in the path: /sys/class/power_supply/BATx/
  CAPACITY=$(cat /sys/class/power_supply/$BATTERY/capacity)
  STATUS=$(cat /sys/class/power_supply/BAT1/status)

  MESSAGE="$CAPACITY%"
  if [[ $CAPACITY -lt 20 ]]; then
    MESSAGE="  ${MESSAGE}"
  elif [[ $CAPACITY -gt 20 && $CAPACITY -lt 40 ]]; then
    MESSAGE="  ${MESSAGE}"
  elif [[ $CAPACITY -gt 40 && $CAPACITY -lt 60 ]]; then
    MESSAGE="  ${MESSAGE}"
  elif [[ $CAPACITY -gt 60 && $CAPACITY -lt 80 ]]; then
    MESSAGE="  ${MESSAGE}"
  else
    MESSAGE="  ${MESSAGE}"
  fi

  if [ $STATUS == "Charging" ]; then
    MESSAGE="󱐋${MESSAGE}"
  fi

  echo "$MESSAGE"
}

get_hour() {
  echo "󰥔  $(date '+%H:%M')"
}

get_date() {
  echo "  $(date '+%A %d-%m-%Y')"
}

get_cpu_temp() {
  CPU_TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
  CPU_TEMP=$(bc <<<"scale=2;  ${CPU_TEMP}/1000")

  echo " $CPU_TEMP°C"
}

get_ram() {
  TOTAL_MEM="$(free -h | awk '(NR==2) {print $2}')"
  USED_MEM="$(free -h | awk '(NR==2) {print $3}')"

  echo "  $USED_MEM/$TOTAL_MEM"
}

get_disk_capacity() {
  TOTAL_DISK="$(df -h | awk '{ if ($6 == "/") print $2}')"
  USED_DISK="$(df -h | awk '{ if ($6 == "/") print $3}')"

  echo "  $USED_DISK/$TOTAL_DISK"
}

get_network() {
  WIFI_STATUS=$(cat /sys/class/net/$WIFI_INTERFACE/operstate)
  ETH_STATUS=$(cat /sys/class/net/$ETH_INTERFACE/operstate)

  if [[ $WIFI_STATUS == "up" ]]; then
    WIFI_SSID=$(nmcli dev | awk '{ if($2=="wifi" && $3=="connected"){ $1=$2=$3=""; print $0 } }' | awk '{ $1=$1; print $0 }')
    echo "  $WIFI_SSID"
  elif [[ $ETH_STATUS == "up" ]]; then
    echo "󰈀  $ETH_INTERFACE"
  else
    echo "󱛅  Not Connected"
  fi
}

while true; do
  xsetroot -name "| $(get_cpu_temp) | $(get_ram) | $(get_disk_capacity) | $(get_hour) | $(get_date) | $(get_network) "
  sleep 1
done
