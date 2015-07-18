#!/bin/bash
#
# simple stopwatch
#

echo -ne "\nPress:\t\"Enter\" to show meantime\n\t\"Strg + C\" to abort\n\n"

BEGIN=$(date +%s)
while true; do
    NOW=$(date +%s)
    DIFF=$(($NOW - $BEGIN))
    MINS=$(($DIFF / 60))
    SECS=$(($DIFF % 60))
    echo -ne "Time elapsed: $MINS:`printf %.02d $SECS`\r"
    sleep .1
done
