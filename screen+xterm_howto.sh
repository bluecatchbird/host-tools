#!/bin/sh
#
# simple howto to use xterm with screnn
# to use several tabs and switch them 
# with ctrl+arrow-key
#


# install on arch linux
pacman -S xterm screen


# screen config
cat > ~/.screenrc << 'EOF'
# needed to source .bashrc
defshell -bash

# logging
deflog on
# logfile '~/screen_%H_%1-%t.%n'
logtstamp on

# set user defined shell
# shell "/bin/zsh"


# set your status bar
# caption always "%{= kw}%-w%{= BW}%n %t%{-}%+w %-= @%H - %LD %d %LM - %c"
caption always "%{= wk} %-w%{= KW} [%n %t] %{-}%+w %= | @%H | %l | %Y-%m-%d %c "

# buffersize
defscrollback 5000

# scroll via mousewheel, procedure refresh
termcapinfo xterm* ti@:te@

# for switch tab with ctrl right and left arrows
bindkey ^[[1;5D prev
bindkey ^[[1;5C next

# jump to tab number
# bindkey ^[[1;1 select 1

# create new tab with ctrl T
bindkey ^T screen

# disable visual bell
vbell off

# default startup with serial console
screen -t ttyUSB0 0 screen /dev/ttyUSB0 115200
screen -t ttyUSB1 1 screen /dev/ttyUSB1 115200
screen -t home    2

# select region with mouse
# mousetrack on

# bindings for regions control
bind u focus up
bind n focus down
bind h focus top
bind j focus bottom

bindkey ^u focus up
bindkey ^n focus down
bindkey ^h focus left
bindkey ^j focus right

EOF



# xterm config
cat > ~/.Xresources << 'EOF'
!
! Comments begin with a "!" character.
! run this command to act. your config:
! $ xrdb -merge ~/.Xresources
!
 
XTerm*background:       black
XTerm*foreground:       white
XTerm*cursorColor:      steel blue
XTerm.vt100.geometry:   80x25
XTerm*scrollBar:        true
XTerm*scrollTtyOutput:  false
XTerm*saveLines:        50000
XTerm*loginShell:       true
XTerm*metaSendsEscape:  true
 
! Font
xterm*faceName: DejaVu Sans Mono:style=Book
xterm*faceNameDoublesize: WenQuanYi Bitmap Song
xterm*faceSize: 9
EOF


# add alias to shell
cat >> ~/.bashrc << 'EOF'
alias xtermscreen="xterm -e screen"
EOF
