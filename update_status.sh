#!/bin/sh

[ $UPDATE_INTERVAL -ge 1 ] || UPDATE_INTERVAL=30

while [ true ]; do
	/usr/local/bin/php /app/cron/status.cron.php
	sleep $UPDATE_INTERVAL
done
