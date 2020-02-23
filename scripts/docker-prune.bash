#!/bin/bash
# prune docker images and btrfs subvolume snapshots
dkr_snap_date="2020-01-11"		# snapshot date to delete
snap_path="/media/pool/snaptshots/"
dkr_app="resilio"

echo 'Alfa script, DANGER! Waiting 30s'

wait 30

find ${snap_path} -maxdepth 1 -name "$dkr_app_$dkr_snap_date*" -exec sudo btrfs subvolume delete {} \;

docker container rm $(docker container ls -a --format "table {{.Names}}" | grep -i $dkr_app | grep -i $dkr_snap_date) 
