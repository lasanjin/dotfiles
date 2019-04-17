 #!/bin/bash 

#weather
w() {
if [ -z $1 ];then 
    echo "Invalid input"
    return 0
fi

local url='http://wttr.in/'
local ndays=0

if [ ! -z $2 ]; then
    if [[ "$2" =~ ^[0-9]$ ]]; then
        ndays=$2
    fi
fi

if [ $1 == "home" ]; then
	echo -e "\nWeather report: Blackevägen \n" &&
	sudo curl $url'57.7173939,11.9222907?M?Q?'"$ndays"
elif [ $1 == "chalmers" ]; then
	echo -e "Weather report: Chalmers \n" &&
	sudo curl $url'57.6897276,11.9732173?M?Q?'"$ndays"
elif [ $1 == "gothenburg" ]; then
	echo -e "Weather report: Göteborg \n"
	sudo curl $url'gothenburg?M?Q?'"$ndays"
elif [ $1 == "custom" ]; then
	sudo curl $url"$ndays"'?M'
elif [ $1 == "-moon" ]; then
	sudo curl '$url'moon"$ndays"
fi

echo -e ""
}

#show all weather
weather() {
local ndays=0

if ! [[ "$1" =~ ^[0-9]*$ ]]; then 
    echo "Invalid input"
    return 0
elif [ ! -z $1 ]; then
    ndays=$1
fi

w "home" "$ndays" && \
w "chalmers" "$ndays" && \
w "gothenburg" "$ndays"
}