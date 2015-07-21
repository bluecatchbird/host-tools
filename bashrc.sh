#!/bin/bash
#
# usefull bashrc tools
#


# color error exit
EC() {
	echo -e '\e[1;33m'code $?'\e[m\n'
}
trap EC ERR

# create folder and change into it
mkcd()
{
  mkdir $1;
  cd $1
}

# remove dir safer
rmd()
{
	FOLDER=$(pwd)
	printf "Remove $FOLDER(n,y)?"
	read INPUT
	[ "$INPUT" == "y" ] || echo "abort" && return 0
	cd ..
	rm -r $FOLDER
}

# extraction of archives from
#  https://wiki.archlinux.org/index.php/Bash/Functions#Extract
extract() {
    local c e i

    (($#)) || return

    for i; do
        c=''
        e=1

        if [[ ! -r $i ]]; then
            echo "$0: file is unreadable: \`$i'" >&2
            continue
        fi

        case $i in
            *.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz)))))
                   c=(bsdtar xvf);;
            *.7z)  c=(7z x);;
            *.Z)   c=(uncompress);;
            *.bz2) c=(bunzip2);;
            *.exe) c=(cabextract);;
            *.gz)  c=(gunzip);;
            *.rar) c=(unrar x);;
            *.xz)  c=(unxz);;
            *.zip) c=(unzip);;
            *)     echo "$0: unrecognized file extension: \`$i'" >&2
                   continue;;
        esac

        command "${c[@]}" "$i"
        ((e = e || $?))
    done
    return "$e"
}

# simpe calculator
calc() {
    echo "scale=3;$@" | bc -l
}

# screen
cowsay -f $(ls /usr/share/cowsay/ | shuf -n 1) $(fortune)
echo -e "\n\n"

# fix backspace issue ^?
stty erase '^?'

alias quit=exit
alias c="cd .."
alias xtermscreen="xterm -e screen"
