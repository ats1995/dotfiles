#!/bin/bash
# prune docker images and btrfs subvolume snapshots
dkr_snap_date="2019-11"
snap_path="/media/pool/snapshots/"
#dkr_app="unifi-ctrl"
dkr_app="resilio"

echo 'Alfa script, DANGER! Waiting 5s'
echo "Deleting ${dkr_app} from ${dkr_snap_date}"

sleep 5

sudo btrfs subvolume delete $(find ${snap_path} -maxdepth 1 -name "${dkr_app}_${dkr_snap_date}*")
#find ${snap_path} -maxdepth 1 -name "${dkr_app}_${dkr_snap_date}*"

docker container rm $(docker container ls -a --format "table {{.Names}}" | grep -i $dkr_app | grep -i $dkr_snap_date) 
