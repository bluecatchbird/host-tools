#!/bin/sh
#
# generate a script with binary payload
#

alias print_help="echo \"$0 input_script.sh input_binary output_script.sh\""


if [ "$#" -ne "3" ]
then
	echo "number of args is invalid, abort!"
	print_help
	exit 1
fi

INPUT_SCRIPT=$1
INPUT_BINARY=$2

OUTPUT_SCRIPT=$3




if [ ! -e $INPUT_SCRIPT ] || [ ! -e $INPUT_BINARY ]
then
	echo "no valid input(file does not exist), abort!"
	print_help
	exit 1
fi




lineCount=$(wc -l "$INPUT_SCRIPT" | cut -f 1 -d ' ')  # just get the line count of input script
lineCount=$(($lineCount+3))                           # because we are going to append a line
                                                      # 3 = 1 line shebang + 1line extraction cmd + 1 line exit

{
	head -n 1 "$INPUT_SCRIPT"                         # this is done to ensure that shebang is preserved
	echo "tail -n +$lineCount \$0 > $INPUT_BINARY;"   # add extraction of binary
	tail -n +2 "$INPUT_SCRIPT"                        # skip shebang of input script
	echo "exit 0"
	cat "$INPUT_BINARY"                               # add binary payload
} > "$OUTPUT_SCRIPT"  

chmod +x $OUTPUT_SCRIPT
ls -lah $OUTPUT_SCRIPT

echo "now you can run: \$ ./$OUTPUT_SCRIPT"

exit 0
