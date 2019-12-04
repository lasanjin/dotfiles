#!/bin/bash

# - - - - - - - - - - - LOAD PATHS etc. - - - - - - - - - - - -
source ~/.miscellaneous

# - - - - - - - - - - - KEYS - - - - - - - - - - - -
# Ctrl+left/right  arrow
bind '"\e[1;5D" backward-word'
bind '"\e[1;5C" forward-word'

# - - - - - - - - - - - ALIASES - - - - - - - - - - - -
#bash files
alias codealias='code ~/.bash_aliases'
alias rbash='source ~/.bash_aliases'

#sudo
alias sudocode='sudo code --user-data-dir="~/.vscode-root"'
alias please='sudo $(fc -ln -1)'

#system
alias sleep="sudo systemctl suspend"
alias die="sudo shutdown -h now"

#No need for cd
shopt -s autocd

#directories
alias trash="cd ~/.local/share/Trash/files/"
alias dev="cd ~/dev"
alias repos="cd $repdir"

#copy & paste output
alias pasteo='xclip -selection clipboard -o'
copyo() {
    $@ | xclip -selection clipboard
}

#tree
alias t='sudo tree'

#generate 10 random chars
alias pass="openssl rand -base64 11"

#calculator
alias calc='bc -l'

#time & date
alias now='date +%T'
alias calendar='run gnome-calendar'

#clean trash & history
alias cleant="sudo rm -rf ~/.local/share/Trash/files*"
alias cleanh="cat /dev/null > ~/.bash_history && history -c"

#notes
alias notes="cd $notesdir"

#spellcheck single words
alias spell='aspell -a'

#battery
alias bat="upower -i $(upower -e | grep 'BAT') | \
grep --color=never 'time\|percentage' | sed -e 's/[^0-9]*//'"

#kill
alias kill='sudo kill -9'

#list ports in usek
alias ports='sudo lsof -i -P -n'

#change java version
alias javas='sudo update-alternatives --config java'

# - - - - - - - - - - - FUNCTIONS - - - - - - - - - - - -
#volume form main sound and the HDMI
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
findw() {
    # TODO: fix + add case-sensitive option
    grep -rnw "$3" "$2" -e "$1"
}

#search filename ($1) in directory ($2) with maxdepth ($3)
findf() {
    if [ -z "$1" ]; then
        echo "Invalid input"
    elif [ "$2" == "." ]; then
        find . -maxdepth 1 -iname "*$1*"
    elif ! [ -z "$2" ]; then
        if [ "$3" == "." ]; then
            find $2 -maxdepth 1 -iname "*$1*"
        elif [[ "$3" =~ ^[0-9]+$ ]] && [ $3 -ge 1 ]; then
            find $2 -maxdepth $3 -iname "*$1*"
        else
            find $2 -iname "*$1*"
        fi
    else
        find . -iname "*$1*"
    fi
}

#note
note() {
    # TODO: replace uniq with ordered number notes / day
    local uniq=$(date '+%F-%N')
    local name='note-'$uniq''
    local dir=$notesdir
    touch $dir$name
    echo -e $(date +%F)'\n' >$dir$name
    o $dir$name
}

#compile and run cpp
gpp() {
    g++ -Wall -o main $1
    chmod +x main
    ./main
}

#compile and run java
jj() {
    javac $1
    java $(echo $1 | cut -f1 -d".") ${@:2}
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

pi() {
    if [[ "$1" =~ ^[0-9]+$ ]] && [ $1 -ge 1 ]; then
        python -c "from mpmath import mp; mp.dps=$1; print mp.pi"
    fi
}

# - - - - - - - - - - - CHALMERS - - - - - - - - - - - -
alias ta="cd $tadir"
alias funkis="cd $funkdir"
alias distr="cd $distrdir"
