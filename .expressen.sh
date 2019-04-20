#!/bin/bash

#expressen menu
#$1: <#days from today>
#$2: <language>, s for swedish, default is english
lunch() {
	#number of days from today
	local ndays=0

	#check if input null
	if [ ! -z $1 ]; then
		ndays=$1

		#check if input digit or negative
		if ! [[ "$1" =~ ^[0-9]*$ ]] || [ $1 -lt 0 ]; then
			echo -e "\nInvalid input\n"
			return 0
		fi
	fi

	local today=$(date +'%Y-%m-%d')
	local end_date=$(date -d "$today+$ndays days" +'%Y-%m-%d')

	#api url
	expressen_url
	local URL=''$url'?startDate='$today'&endDate='$end_date''

	#get data
	expressen_data "$URL" "$2"
	local data=$expressen_data
	if [ -z "$data" ]; then
		echo -e "\nNo data\n"
		return 0
	fi

	#IFS (internal field separator) variable is used to determine what characters 
	#Bash defines as words boundaries when processing character strings.
	IFS=$'\n'
	
	#store data in array
	read -r -a arr -d '' <<<"$data"
	
	#reset back to default value
	unset IFS

	style
	local length=${#arr[@]}
	local temp=''
	#data is stored: [date0, meat0, date0, veg0, date1, meat1, date1, veg1, ...]
	for ((i = 0; i < $length; i += 2)); do

		#trim citation
		local date=${arr[i]}
		local food=${arr[$((i + 1))]}

		if [ "$date" != "null" ] && [ "$food" != "null" ]; then
			if [ "$date" != "$temp" ]; then
				if [ "$2" == "s" ]; then
					#swedish
					echo -e "\n$bold$green$(LC_TIME=sv_SE.utf-8 date --date "$date" +'%A')$default:"
				else
					#english
					echo -e "\n$bold$green$(date --date "$date" +'%A')$default:"
				fi

				temp=$date
			fi

			is_it_meatballs "$food" "$2"
			index=$index
			end="$(echo $ingredient | awk '{print length}')"

			if [[ ! -z "$index" ]]; then
				echo -e "$blink$bold$red${food:$index:$end}$default${food:$end}"
			else
				echo -e "$food"
			fi
		fi
	done

	echo -e ""
}

#expressen data, standard lang: eng
expressen_data() {
	#get eng or swe menu
	local lang=1
	if [ "$2" == "s" ]; then
		lang=0
	fi

	expressen_data=$(curl -s $1 | jq -r '.[] | .startDate, .displayNames['$lang'].dishDisplayName')
}

#expressen api
expressen_url() {
	local api='v1/mealprovidingunits/3d519481-1667-4cad-d2a3-08d558129279/dishoccurrences'
	url='http://carbonateapiprod.azurewebsites.net/api/'$api''
}

#return index if string contains 'MEATBALLS' or 'KöTTBULLAR'
is_it_meatballs() {
	ingredient='MEATBALLS'
	if [ "$2" == "s" ]; then
		ingredient='KöTTBULLAR'
	fi

	local capital="$(echo $1 | tr a-z A-Z)"
	index="$(echo $capital | grep -b -o $ingredient | awk 'BEGIN {FS=":"}{print $1}')"
}

style() {
	default='\e[0m'
	bold='\e[1m'
	blink='\e[39m\e[5m'
	green='\e[32m'
	red='\e[31m'
}
