#!/bin/bash
# Script to test a disk hard for fails. Run as root

baddevice=$1
# Greps for device name and discards the two first words ("Device model")
# Then sanitizes and removes trailing _ (?!)
badname=$(smartctl -a ${baddevice} |\
          grep -i "Device model" |\
          awk '{for (i=3; i<=NF; i++) print $i}' |\
          sed 's/\//_/g' |\
          tr '\n' '_' |\
          sed 's/_$//')

# $1 = # of seconds
# $@ = What to print after "Waiting n seconds"
countdown() {
  secs=$1
  shift
  msg=$@
  while [ $secs -gt 0 ]
  do
    printf "\r\033[KWaiting %.d seconds $msg" $((secs--))
    sleep 1
  done
  echo
}

sectotime () {
  local T=$1
  DAYS=$((T/60/60/24))
  HOURS=$((T/60/60%24))
  MINUITES=$((T/60%60))
  TSECONDS=$((T%60))

  # Sets plural 's'
  if [ $DAYS != 1 ]; then
      DAYPLUR=s
  fi
  if (( DAYS > 0 )); then
    printf '%s day%s, ' "$DAYS" "$DAYPLUR"
  fi
}

read -p "Are you sure? ALL data will be lost on ${badname}" -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  printf '\nAborted\n'
  exit
fi
printf '\n'
read -p "Are you REALLY sure? Badblocks will overwrite the disk FOUR times! There is NO way back!" -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  printf '\nAborted\n'
  exit
fi
printf '\n'
countdown 10 "before proceeding"
startdate=$(date +%s)
sleep 1
badbfile=${badname}_$(date "+%F_%H%M%S-%z")".badblocks"
#badblocks -svw -o "${badname}_$(date "+%F_%H%M%S-%z").badblocks" ###"${baddevice}"
printf 'Badblocks finished on %s after ' "$(date "+%F %T %z")"
sectotime $(($(date +%s) - ${startdate}))
printf '%02d:%02d:%02d\n' "$HOURS" "$MINUITES" "$TSECONDS"
smartctl --quietmode=silent -t short ${baddevice}
printf 'Started SMART on %s\n' "$badname"

while $(smartctl -c /dev/sda | grep --quiet -i " of test remaining"); do
  echo "SMART test running, sleeping 1min"
  sleep 10m
done

printf 'Badblocks and smartctl finished on %s after ' "$(date "+%F %T %z")"
sectotime $(($(date +%s) - ${startdate}))
printf '%02d:%02d:%02d\n' "$HOURS" "$MINUITES" "$TSECONDS"

smartctl -a $baddevice >> ${badbfile}
printf 'SMART stats written to %s\n' "$badbfile"