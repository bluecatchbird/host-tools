#!/bin/sh
#
# a simpe http server to share files
#

FILENAME=$1
PORT=$2

HEADER="HTTP/1.0 OK\r\nContent-lenght: $(stat --format=%s $FILENAME)\r\nContent-type: application/plain\r\nContent-disposition: attachment; filename=$(basename $FILENAME)\r\n\r\n"

printf "$HEADER$(cat $FILENAME)" | nc -l $PORT

exit 0
