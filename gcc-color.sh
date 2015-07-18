#!/bin/sh


###########################################
#                                         #
# use this script to highlight gcc errors #
# and warnings and pipe them to stderr    #
# usage: make 2>&1 | gcc-color.sh         #
#                                         #
###########################################



GRAY="30"
RED="31"
GREEN="32"
YELLOW="33"

declare -A WORDS
declare -A COLOR

WORDS[0]="warning:"
WORDS[1]="error:"
WORDS[2]="notice:"

COLOR[${WORDS[0]}]=$YELLOW
COLOR[${WORDS[1]}]=$RED
COLOR[${WORDS[2]}]=$GREEN


cat - | while read LINE; 
do
	OUT="/dev/stdout"
	for WORD in ${WORDS[@]}
	do
		if [[ $(echo $LINE | tr '[:upper:]' '[:lower:]') == *"$WORD"* ]]
		then
			LINE="\033[1;${COLOR[$WORD]}m${LINE}\033[0m"
			OUT="/dev/stderr"
			break;
		fi
	done
	echo -e $LINE > $OUT
done
