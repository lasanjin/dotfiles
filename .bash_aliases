#bash
alias cbash='code ~/.bashrc'
alias nbash='sudo nano ~/.bashrc'

#sudo vscode 
alias scode='sudo code --user-data-dir="~/.vscode-root"'

#reload bash
alias rbash='. ~/.bash_aliases'

#open:
alias open="sudo xdg-open"

#system
alias sleep="sudo systemctl suspend"
alias die="sudo shutdown -h now"

#bluetooth
blue () {
cd ~/../../etc/init.d/ && sudo bluetooth "$1" && cd ~
}

#mint note
note () {
RB="\n"
sudo echo -e "\n\n$1\n$2" >> ~/Documents/mint\ setup
}

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

#weather
w() {
source ~/.weather.sh
w $1 $2	
}

#weather
weather() {
source ~/.weather.sh
weather $1
}

#expressen lunch
lunch() {
source ~/.expressen.sh
lunch $1 $2
}