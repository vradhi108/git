#!/bin/bash

<<info
this file is used to create bash script to automate backups
backups.sh <source> <destination> (argumnets)
info

src=$1
dest=$2
timestamp=$(date '+%Y-%m-%d-%H-%M')

zip -r "$dest/backup-$timestamp.zip" $src
aws s3 sync $dest s3://backups-practice

echo "backup completed"

