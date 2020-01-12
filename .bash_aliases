#!/bin/bash

# - - - LOAD PATHS, VARIABLES etc. - - -
source ~/.miscellaneous

# - - - KEYS - - -
#ctrl+left/right+arrow
bind '"\e[1;5D" backward-word'
bind '"\e[1;5C" forward-word'

#- - - ALIASES - - -
alias sleep="sudo systemctl suspend"
alias die="sudo shutdown -h now"
alias kill='sudo kill -9'
#redo cmd in sudo
alias pls='sudo $(fc -ln -1)'
#battery
alias bat="upower -i $(upower -e | grep 'BAT') | \
grep --color=never 'time\|percentage' | sed -e 's/[^0-9]*//'"
#list ports in usek
alias ports='sudo lsof -i -P -n'
#No need for cd
shopt -s autocd
#bash files
alias cbash='code ~/.bash_aliases'
alias rbash='source ~/.bash_aliases'
#directories
alias trash="cd ~/.local/share/Trash/files/"
alias dev="cd ~/dev"
alias repos="cd $repdir"
alias notes="cd $notesdir"
alias ta="cd $tadir"
alias funkis="cd $funkdir"
alias distr="cd $distrdir"
#tree
alias t='sudo tree'
#gen 10 random chars
alias pass="openssl rand -base64 11"
#time
alias now='date +%T'
#sudo vscode
alias scode='sudo code --user-data-dir="~/.vscode-root"'
#spellcheck single words
alias spell='aspell -a'
#clean trash & history
alias cleant="sudo rm -rf ~/.local/share/Trash/files*"
alias cleanh="cat /dev/null > ~/.bash_history && history -c"
#java versions
alias javas='sudo update-alternatives --config java'
#python versions
alias pythons='sudo update-alternatives --config python'
#paste clipboard
alias po='xclip -selection clipboard -o'
#spotify
alias pp='spotify pp'
alias n='spotify next'
alias p='spotify prev'
alias stop='spotify stop'

#- - - SCRIPTS - - -
#copy cmd output
co() {
    $@ | xclip -selection clipboard
}

#git status -$@ for all repositories in $repdir
gs() {
    find $repdir -maxdepth 2 -name ".git" \
        -execdir sh -c '(echo "\033[94m"${PWD##*/}"\033[0m")' \; \
        -execdir git status $@ \; \
        -exec echo \;
}

#volume: main sound & HDMI
sound() {
    if [ "$1" == "on" ]; then
        amixer -q -D pulse sset Master on
    elif [ "$1" == "off" ]; then
        amixer -q -D pulse sset Master off
    elif [[ "$1" =~ ^[0-9]+$ ]] && [ $1 -ge 0 ] && [ $1 -le 150 ]; then
        amixer -q -D pulse sset Master $1%
    else
        echo "Invalid input"
    fi
}

#search word ($1) in file ($2)
# ${@:3} additional params, e.g. ignore case: -i
findw() {
    grep -rnw ${@:3} "$2" -e "$1"
}

#search fname ($1) in dir ($2) with maxdepth ($3)
# ${@:X} params, e.g. -delete
findf() {
    if [ -z "$1" ]; then
        echo "Invalid input"
    elif [ "$2" == "." ]; then
        find . -maxdepth 1 -iname "*$1*" ${@:3}
    elif [[ "$2" == *"/"* ]]; then
        if [ "$3" == "." ]; then
            find $2 -maxdepth 1 -iname "*$1*" ${@:3}
        elif [[ "$3" =~ ^[0-9]+$ ]] && [ $3 -ge 1 ]; then
            find $2 -maxdepth $3 -iname "*$1*" ${@:4}
        else
            find $2 -iname "*$1*" ${@:3}
        fi
    else
        find -iname "*$1*" ${@:2}
    fi
}

#create & open note-yyyy-mm-dd-seq#
note() {
    # local uniq=$(date '+%N')
    local date=$(date '+%F')
    local f='note-'$date'-'
    local fs=$notesdir$f*
    local seq
    if ls -U $fs &>/dev/null; then
        seq=$(ls $fs | sort -n -t - -k 2 | tail -1 | sed 's/.*\-//')
        ((seq++))
    else
        seq='1'
    fi
    local name=$f$seq
    touch $notesdir$name
    echo -e $date'\n' >$notesdir$name
    o $notesdir$name
}

#compile and run cpp
gpp() {
    g++ -Wall -o main $1
    chmod +x main
    ./main
}

#compile and run java with params
jj() {
    local f=$(echo $1 | sed "s@.*/@@" | cut -f1 -d".")
    local path=$(echo $1 | sed "s/"$f".*//")
    javac -cp $path $1
    java -cp $path $f ${@:2} | sed "s@.*/@@" | cut -f1 -d"." -
}

#change mouse sensitivity
mouse() {
    local re='^[+-]?[0-9]+([.][0-9]+)?$'
    if [[ "$1" =~ $re ]] && [ $1 -ge -2 ] && [ $1 -le 2 ]; then
        local id=$(xinput |
            grep --color=never "$mouse.*pointer" |
            sed -e 's/.*id=//' |
            sed 's/\s.*$//')
        xinput --set-prop $id "libinput Accel Speed" $1
    fi
}

#redshift
red() {
    if [ "$1" == "stop" ]; then
        redshift -x
    elif [[ "$1" =~ ^[0-9]+$ ]] && [ $1 -ge 20 ] && [ $1 -le 65 ]; then
        redshift -O $(($1 * 100))
    else
        echo "Invalid input"
    fi
}

#bluetooth
blue() {
    if [ "$1" == "on" ] || [ "$1" == "off" ]; then
        local current_dir=$(pwd)
        cd /etc/init.d/ &&
            sudo bluetooth "$1" &&
            cd "$current_dir"
    else
        echo "Invalid input"
        return 0
    fi
}

#monitor
screen() {
    if [ -z $1 ]; then
        echo "Invalid input"
    elif [[ "$1" =~ ^[0-9]+$ ]] && [ $1 -ge 1 ] && [ $1 -le 100 ]; then
        local param=$(bc <<<"scale=2; $1/100")
        xrandr --output DP-2 --brightness $param
    fi
}

#open
o() {
    if [ -z "$1" ]; then
        echo "Invalid input"
        return 0
    fi
    xdg-open "$1" &>/dev/null
}

#clean dns
cleandns() {
    local current_dir=$(pwd)
    cd /etc/init.d/ && sudo service dns-clean start
    cd "$current_dir"
}

#uninstall app
remove() {
    sudo apt-get --purge remove $1
    sudo apt-get autoremove
}

#copy bash files
copybash() {
    sudo cp -rf ~/.bash_aliases "$repdir"dotfiles
}

#expressen lunch
express() {
    . "$repdir"chalmers-lunch-cli/expressen.sh $1 $2 $3
}

#amazing pi calc
pi() {
    if [[ "$1" =~ ^[0-9]+$ ]] && [ $1 -ge 1 ]; then
        python -c "from mpmath import mp; mp.dps=$1; print mp.pi"
    fi
}

spotify() {
    CMD="dbus-send --print-reply=literal \
    --dest=org.mpris.MediaPlayer2.spotify \
    /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player"

    case "$1" in
    "pp")
        ${CMD}.PlayPause
        ;;
    "next")
        ${CMD}.Next
        ;;
    "prev")
        ${CMD}.Previous
        ;;
    "stop")
        ${CMD}.Stop
        ;;
    *)
        echo "Invalid input"
        ;;
    esac
}
