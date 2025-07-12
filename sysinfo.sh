#!/bin/sh
cyan="\e[0;36m"
bcyan="\e[1;36m"
red="\e[0;91m"
bred="\e[1;91m"
blue="\e[0;94m"
bblue="\e[1;94m"
green="\e[0;92m"
bgreen="\e[1;92m"
gray="\e[0;37m"
bgray="\e[1;37m"
yellow="\e[0;33m"
bgray="\e[0;37m"
byellow="\e[1;33m"
white="\e[0;97m"
bold="\e[1m"
uline="\e[4m"
magenta="\e[0;35m"
bmagenta="\e[1;35m"
reset="\e[0m"

countryip=""
ip=$(curl -s "icanhazip.com")
if [ "${ip}" != "" ] ; then
	location=$(whois "${ip}" | grep country | head -n 1 | cut -d ':' -f 2 | xargs)
	countryip="${bred}${location}${red}${ip}${reset}"
fi

time_now=$(date +'%H:%M:%S')
date_now=$(date +'%Y/%m/%d')
uptime_out=$(uptime -p)
uptime_out=$(echo "$uptime_out" | awk '{gsub(/ year, /, "y:"); gsub(/ month, /, "m:"); gsub(/ weeks, /, "w:"); gsub(/ week, /, "w:"); gsub(/ day, /, "d:"); gsub(/ days, /, "d:"); gsub(/ hours, /, "H:"); gsub(/ hour, /, "H:"); gsub(/ minutes/, "M"); gsub(/ minute/, "M"); print}')

battery="None"
battery_status=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "power supply" | cut -d ':' -f 2 | xargs)
if [ "$battery_status" = "yes" ] ; then
  battery="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | cut -d ':' -f 2 | xargs)"
fi

fan=$(sensors | grep fan1 | cut -d ':' -f 2 | xargs)
temp=$(sensors | grep CPU | cut -d ':' -f 2 | xargs)
temperature="$temp $fan"

#clear
echo ${yellow}${date_now}${reset} ${byellow}${time_now}${reset} ${blue}${uptime_out}${reset} ${countryip} ${bmagenta}${temperature}${reset}"\b" ${cyan}BAT:${bcyan}${battery}${reset}

# If you want to display jalali calender uncomment:
#echo
#jcal
