#!/bin/sh
#
# get all dependencies libraries from a cross compiled binary
#

help()
{
	echo "Usage:"
	echo "$0 CROSS_COMPILE_PREFIX CROSS_SYSROOT BINARY"
	echo "Example:"
	echo "$0 arm-linux- /path/to/your/sysroot/with/librarys/ binary.arm"
}

if [ "$1" == "--help" ] || [ "$#" != 3 ]
then
	help
	exit 0
fi

CHECKED_LIBS=""

getLibs()
{
	echo "check: $1"
	for LIB in $(readelf -d $1 | grep NEEDED | awk '{print $5}' | sed 's,\[,,g' | sed 's,\],,g')
	do
		if [ -n "$(echo ${CHECKED_LIBS} | grep ${LIB})" ]
		then
			# echo "already tested: $LIB"
			continue
		fi
		CHECKED_LIBS+=" ${LIB}"
		LIB=$(find $CROSS_SYSROOT -name $LIB 2>/dev/null)
		getLibs $LIB
	done
}


CROSS_COMPILE_PREFIX=$1
CROSS_SYSROOT=$2
FILE=$3

alias readelf=${CROSS_COMPILE_PREFIX}readelf

getLibs $FILE | sort -u

