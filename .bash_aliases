# - - - - - - - - - - - CHALMERS - - - - - - - - - - - -
alias ta="cd ~/documents/chalmers/TA"
alias chalmers="cd ~/documents/chalmers/"

sshchalmers() {
    source .secret
    ssh -R 52698:localhost:52698 $SSH_CHALMERS
}

gitinspect() {
    ~/devel/repos/gitinspector/gitinspector.py --grading $1
}

tagroup() {
    if [[ "$1" =~ ^[0-9]+$ ]] && [ $1 -ge 17 ] && [ $1 -le 20 ]; then
        local current_dir=$(pwd)
        cd ~/documents/chalmers/TA && \
            code guidelines.md && \
            cd groups && \
            code 'group'$1'/group'$1'.md' && \
            cd "$current_dir"
    else
        echo "Invalid input"
        return 0
    fi
}

# - - - - - - - - - - - KEYS - - - - - - - - - - - -
# Ctrl+left/right  arrow
bind '"\e[1;5D" backward-word'
bind '"\e[1;5C" forward-word'

# - - - - - - - - - - - ALIASES - - - - - - - - - - - -
#bash files
alias codealias='code ~/.bash_aliases'
alias codebash='code ~/.bashrc'
alias nanoalias='sudo nano ~/.bash_aliases'
alias nanobash='sudo nano ~/.bashrc'

#sudo vscode
alias sudocode='sudo code --user-data-dir="~/.vscode-root"'

#reload bash file(s)
alias rbash='source ~/.bash_aliases'

#system
alias sleep="sudo systemctl suspend"
alias die="sudo shutdown -h now"

#change directory
alias ..="cd ../../"
alias ...="cd ../../../"
alias dev="cd ~/devel"
alias repos="cd ~/devel/repos"

#tree
alias t='sudo tree'

#generate 20 random chars
alias getpass="openssl rand -base64 20"

#calculator
alias calc='bc -l'

#time
alias now='date +%T'

#gnome-calendar
alias calendar='run gnome-calendar'

#intellij
alias intellij='echo "Starting IntelliJ..." && 
. ~/devel/idea-IU-183.5912.21/bin/idea.sh &>/dev/null &'

#empty trash
alias cleantrash="sudo rm -rf ~/.local/share/Trash/files*"

#notes
alias notes="code ~/devel/repos/notes/linux/LINUX.md"
alias codenotes="code ~/devel/repos/notes/code/TOOLS.md"
alias nginxnotes="code ~/devel/repos/notes/code/NGINX.md"

#battery
alias bat="upower -i $(upower -e | grep 'BAT') | \
grep --color=never 'time\|percentage' | sed -e 's/[^0-9]*//'"

# - - - - - - - - - - - FUNCTIONS - - - - - - - - - - - -
#compile and run cpp
cpp() {
    g++ -o output $1
    chmod +x output
    ./output $2
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
        cd ~/../../etc/init.d/ && \ 
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
    if [ -z ! $1 ]; then
        echo "Invalid input"
        return 0
    fi

    xdg-open $1 &>/dev/null &
}

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

#clean dns
cleandns() {
    local current_dir=$(pwd)
    cd /etc/init.d/ &&
        sudo service dns-clean start
    cd "$current_dir"
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

#uninstall app
remove() {
    sudo apt-get --purge remove $1
    sudo apt-get autoremove
}

#copy bash files
copybash() {
    sudo cp \
        -rf ~/.bash_aliases \
        ~/devel/repos/dotfiles
}

#expressen lunch
express() {
    . ~/devel/repos/chalmers-lunch-cli/expressen.sh $1 $2 $3
}
