# - - - - - - - - - - - ALIASES - - - - - - - - - - - -
#bash
alias cbasha='code ~/.bash_aliases'
alias cbash='code ~/.bashrc'
alias nbasha='sudo nano ~/.bash_aliases'
alias nbash='sudo nano ~/.bashrc'

#sudo vscode
alias scode='sudo code --user-data-dir="~/.vscode-root"'

#reload bash
alias rbash='. ~/.bash_aliases'

#open:
alias open="xdg-open &>/dev/null &"

#system
alias sleep="sudo systemctl suspend"
alias die="sudo shutdown -h now"

#change directory
alias ..="cd ../../"
alias ...="cd ../../../"
alias dev="cd ~/devel/github"

#tree
alias t='sudo tree'

#generate 20 random chars
alias getpass="openssl rand -base64 20"

#calculator
alias calc='bc -l'

#time
alias now='date +%T'

#external ip address
alias ipe='curl ipinfo.io/ip'

#gnome-calendar
alias calendar='run gnome-calendar'

#intellij
alias intellij='echo "Starting IntelliJ..." && 
. ~/devel/idea-IU-183.5912.21/bin/idea.sh &>/dev/null &'

#empty trash
alias etrash="sudo rm -rf ~/.local/share/Trash/files*"

#hacker news
alias hack="chrome news.ycombinator.com"

#mint note
alias note="code ~/devel/github/notes/linux/LINUX.md"

# - - - - - - - - - - - FUNCTIONS - - - - - - - - - - - -
#open url
chrome() {
    if [ -z $1 ]; then
        run chromium-browser
    else
        xdg-open 'https://'$1 &>/dev/null &
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
            &>/dev/null &
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

#clean dns
cleandns() {
    local dir=$(pwd)
    cd /etc/init.d/ &&
        sudo service dns-clean start
    cd "$dir"
}

#run app
run() {
    if [ ! -z $1 ]; then
        exec $1 &>/dev/null &
        bg
    else
        echo "Invalid input"
        return 0
    fi
}

#bluetooth
blue() {
    if [ "$1" == "on" ] || [ "$1" == "off" ]; then
        local dir=$(pwd)
        cd ~/../../etc/init.d/ && \ 
        sudo bluetooth "$1" && cd "$dir"
    else
        echo "Invalid input"
        return 0
    fi
}

#copy bash files
copybash() {
    sudo cp \
        -rf ~/.bash_aliases \
        ~/devel/github/dotfiles
}

#uninstall app
remove() {
    sudo apt-get --purge remove $1
    sudo apt-get autoremove
}

#expressen lunch
lunch() {
    dev && cd expressen-lunch-cli/
    ./expressen.sh $1 $2
}

#smhi
smhi() {
    dev && cd smhi-cli/
    ./smhi.sh $1
}