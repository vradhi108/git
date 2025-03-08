#!/bin/bash

<< info
	script for rotational backups
info

source=$1
dest="/home/ubuntu/backups"
function check() {

	total_backups=$(find "$dest" -type f | wc -l)

	while [ "$total_backups" -gt 3 ]; do
		oldest_file=$(ls -rt "$dest" | head -n 1)
		rm -f "$dest/$oldest_file"
		echo "Deleted $oldest_file"

		total_backups=$(find "$dest" -type f | wc -l)
	done

}

function backup() {
	timestamp=$(date '+%Y-%m-%d-%H-%M-%S')
	zip -r "$dest/backup-$timestamp.zip" $source
	echo "BACKUP COMPLETED"

	check
}

backup
