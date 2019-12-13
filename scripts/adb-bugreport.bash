#!/bin/bash
# Short snippet to easily collect debug logs from android devices
# Should be run as "./script.bash /path/to/store/debug/"
adbmodel=$(adb shell getprop ro.product.model)
adbhostn=$(adb shell getprop net.hostname)
echo "$adbhostn"

if [ ! -d $1 ]; then
  echo "Path specified is not valid"
  exit
fi
printf 'adb bugreport from %s:%s\n' "$adbmodel" "$adbhostn"
#touch "$1bugreport-${adbmodel}_${adbhostn}_$(date "+%Y-%m-%d_%H%M%S-%Z").zip"
adb bugreport "$1bugreport-${adbmodel}_${adbhostn}_$(date "+%Y-%m-%d_%H%M%S-%Z").zip"
