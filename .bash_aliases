#!/bin/bash

# - - - - - - - - - - - KEYS - - - - - - - - - - - -
# Ctrl+left/right  arrow
bind '"\e[1;5D" backward-word'
bind '"\e[1;5C" forward-word'

# - - - - - - - - - - - ALIASES - - - - - - - - - - - -
#bash files
alias codealias='code ~/.bash_aliases'
alias codebash='code ~/.bashrc'
alias rbash='source ~/.bash_aliases'

#sudo
alias sudocode='sudo code --user-data-dir="~/.vscode-root"'
alias please='sudo $(fc -ln -1)'

#system
alias sleep="sudo systemctl suspend"
alias die="sudo shutdown -h now"

#A command name that is the name of a directory
#is executed as if it were the argument to the cd command
shopt -s autocd

#directories
alias trash="cd ~/.local/share/Trash/files/"
alias dev="cd ~/dev"
alias repos="cd ~/dev/repos"
alias ..="cd .."
alias ....="cd .. && cd .."
alias ......="cd .. && cd .. && cd .."

#tree
alias t='sudo tree'

#generate 10 random chars
alias pass="openssl rand -base64 11"

#calculator
alias calc='bc -l'

#time
alias now='date +%T'

#gnome-calendar
alias calendar='run gnome-calendar'

#clean
alias cleantrash="sudo rm -rf ~/.local/share/Trash/files*"
alias cleanhistory="cat /dev/null > ~/.bash_history && history -c"

#notes
alias notes="code ~/dev/repos/notes/linux/LINUX.md"
alias codenotes="code ~/dev/repos/notes/code/TOOLS.md"
alias nginxnotes="code ~/dev/repos/notes/code/NGINX.md"

#battery
alias bat="upower -i $(upower -e | grep 'BAT') | \
grep --color=never 'time\|percentage' | sed -e 's/[^0-9]*//'"

#kill
alias kill='kill -9'

#list ports in usek
alias ports='sudo lsof -i -P -n'

#change java version
alias javas='sudo update-alternatives --config java'

# - - - - - - - - - - - FUNCTIONS - - - - - - - - - - - -
#search word in file(s)
findword() {
    grep -nrw $1 -e $2
}

#note
note() {
    local uniq=$(date '+%F:%N')
    local name='note-'$uniq
    echo -e $(date +%F)'\n' >~/$name
    touch ~/$name
    xdg-open ~/$name 2>/dev/null
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
    java $(echo $1 | cut -f1 -d".")
}

mouse() {
    local re='^[+-]?[0-9]+([.][0-9]+)?$'
    if [[ "$1" =~ $re ]] && [ $1 -ge -2 ] && [ $1 -le 2 ]; then
        local id=$(xinput \
        | grep --color=never 'MX Master 2S.*pointer' \
        | sed -e 's/.*id=//' \
        | sed 's/\s.*$//')
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
        param=$(bc <<<"scale=2; $1/100")
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

#open url
chrome() {
    if [ -z $1 ]; then
        run chromium-browser
    else
        xdg-open 'https://'"$1" &>/dev/null
    fi
}

#google search
google() {
    if [ -z $1 ]; then
        echo "Invalid input"
        return 0
    else
        local search=''
        for i in $@; do
            search="$search%20$i"
        done
        xdg-open 'http://www.google.com/search?q='$search \
            &>/dev/null
    fi
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
    sudo cp \
        -rf ~/.bash_aliases \
        ~/dev/repos/dotfiles
}

#expressen lunch
express() {
    . ~/dev/repos/chalmers-lunch-cli/expressen.sh $1 $2 $3
}

# - - - - - - - - - - - CHALMERS - - - - - - - - - - - -
alias ta="cd ~/Documents/chalmers/TA/TDA417"
alias funkis="cd ~/Documents/chalmers/TDA452"
alias distr="cd ~/Documents/chalmers/TDA596"
