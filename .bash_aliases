#!/bin/bash

# ----------------------------------------------------------------------
# LOAD PATHS, VARIABLES etc.
# ----------------------------------------------------------------------
source ~/.miscellaneous
source ~/.chalmers

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
#system
alias blue='bluetooth'
alias kill='sudo kill -9'
alias die="sudo shutdown -h now"
alias sleep="sudo systemctl suspend"
alias size='sudo du -h --max-depth=1 | sort -hr'
#redo cmd in sudo
alias pls='sudo $(fc -ln -1)'
#list ports in use
alias ports='sudo lsof -i -P -n'
#No need for cd
shopt -s autocd
#bash files
alias cbash="code -n $bashfiles"
alias rbash='source ~/.bash_aliases'
#directories
alias repos="cd $repdir"
alias trash="cd $trashdir"
alias notes="cd $notesdir"
alias todo="code -n $tododir/TODO.md"
#tree
alias t='sudo tree'
#gen 10 random chars
alias rand="openssl rand -base64 $1"
#sudo vscode
alias scode='sudo code --user-data-dir="~/.vscode-root"'
#spellcheck single words
alias spell='aspell -a'
#clean trash & history
alias cleant="find $trashdir ! -name . 2>/dev/null | xargs rm -rf"
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
#git traffic
alias gt='python "$repdir"github-traffic/traffic.py'
#messenger
alias fb="$face -execdir {} \; 2>/dev/null"

alias corona="python "$repdir""corona-swe/fhm.py" $@"
