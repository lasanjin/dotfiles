#!/bin/bash

# ----------------------------------------------------------------------
# LOAD PATHS, VARIABLES etc.
# ----------------------------------------------------------------------
source ~/.miscellaneous

# ----------------------------------------------------------------------
# LOAD SCRIPTS
# ----------------------------------------------------------------------
for f in ~/.scripts/*; do source $f; done #chmod +x $f &&

# ----------------------------------------------------------------------
# KEYS
# ----------------------------------------------------------------------
#ctrl+left/right+arrow
bind '"\e[1;5D" backward-word'
bind '"\e[1;5C" forward-word'

# ----------------------------------------------------------------------
# ALIASES
# ----------------------------------------------------------------------
#bash files
alias cbash="code -n $BASHFILES"
alias rbash='source ~/.bash_aliases'
#system
alias getpid="xprop _NET_WM_PID | cut -d' ' -f3"
alias blue='bluetooth'
alias night="red 30 && red b 55"
alias kill='sudo kill -9'
alias die="sudo shutdown -h now"
alias sleep="sudo systemctl suspend"
alias size='sudo du -h --max-depth=1 | sort -hr'
alias count="ls -1 | wc -l"
#redo cmd in sudo
alias pls='sudo $(fc -ln -1)'
#list ports in use
alias ports='sudo netstat -lntup && echo "" && sudo lsof -i -P -n'
#tree
alias t="sudo tree --du -h --sort=size -L $1"
#gen $1 random chars
alias rand="openssl rand -base64 $1"
#sudo vscode
alias scode='sudo code --user-data-dir="~/.vscode-root"'
#spellcheck single words
alias spell='aspell -a'
#clean trash & history
alias cleant="find $TRASHDIR ! -name . 2>/dev/null | xargs rm -rf"
alias cleanh="cat /dev/null > ~/.bash_history && history -c"
#java versions
alias javas='sudo update-alternatives --config java'
alias javacs='sudo update-alternatives --config javac'
#python versions
alias pythons='sudo update-alternatives --config python'
#paste clipboard
alias po='xclip -selection clipboard -o'
#spotify
alias pp='spotify pp'
alias n='spotify next'
alias p='spotify prev'
alias stop='spotify stop'

# ----------------------------------------------------------------------
# OTHER
# ----------------------------------------------------------------------
#No need for cd
shopt -s autocd
