#!/bin/sh
#
# print pdf via network printer
#

IP=$1
PDF=$2

echo "generate pcl file"
gs -sDEVICE=ljet4 -q -dNOPAUSE -dSAFER -sOutputFile=/tmp/tmp.pcl $PDF -c quit

echo "send to printer"
cat /tmp/tmp.pcl | nc $IP 9100

echo "remove tmp files"
rm /tmp/tmp.pcl

echo "done"
