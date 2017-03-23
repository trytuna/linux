#!/usr/bin/env sh
clear

VAR_UPTIME="$(uptime | sed -E 's/^[^,]*up *//; s/, *[[:digit:]]*
user.*//; s/min/minutes/; s/([[:digit:]]+):0?([[:digit:]]+)/\1 hours, \2
minutes/')"
VAR_MEMORY="$(free -m | awk 'NR==2 { printf "Total: %sMB, Used: %sMB,
Free: %sMB",$2,$3,$4; }')"
VAR_SPACE="$(df -h ~ | awk 'NR==2 { printf "Total: %sB, Used: %sB, Free:
%sB",$2,$3,$4; }')"
VAR_BACKUP_SPACE="$(df -h /mnt/smb | awk 'NR==2 { printf "Total: %sB,
Used: %sB, Free: %sB",$2,$3,$4; }')"
VAR_LOADAVG="$(uptime |  awk '{print $10,$11,$12}')"
VAR_PROCESSES="$(ps ax | wc -l | tr -d " ")"
VAR_IP_INTERN="$(hostname -I)"
VAR_LAST_LOGIN_SELF="$(last -i $USER -F | grep -v 'still logged' | head
-1 | awk '{print $6,$5,$8,$7}')"
VAR_DATE="$(date +"%A, %e %B %Y, %R")"
VAR_UNAME="$(uname -snrmo)"
VAR_USERS="$(who -q | head -n 1)"
VAR_LAST_LOGIN="$(last -w -F | grep -v 'logged in' | head -1 | awk
'{print $1 " " $3 " (" $6,$5,$8,$7 " - " $12,$11,$14,$13 ")"}')"

RED=$(tput setaf 1)
GRE=$(tput setaf 2)
YEL=$(tput setaf 3)
BLU=$(tput setaf 4)
WHI=$(tput setaf 7)

echo "${BLU}${VAR_DATE}"
echo "${BLU}${VAR_UNAME}"
echo ""
echo "${GRE}My Last Login${RED}......:${WHI} ${VAR_LAST_LOGIN_SELF}"
echo "${GRE}Last Login${RED}.........:${WHI} ${VAR_LAST_LOGIN}"
echo "${GRE}IP Addresses${RED}.......:${WHI} ${VAR_IP_INTERN}"
echo "${GRE}Uptime${RED}.............:${WHI} ${VAR_UPTIME}"
echo "${GRE}Load Average${RED}.......:${WHI} ${VAR_LOADAVG}"
echo "${GRE}Running Processes${RED}..:${WHI} ${VAR_PROCESSES}"
echo "${GRE}Memory${RED}.............:${WHI} ${VAR_MEMORY}" 
echo "${GRE}Home Space${RED}.........:${WHI} ${VAR_SPACE}" 
echo "${GRE}Backup Space${RED}.......:${WHI} ${VAR_BACKUP_SPACE}"
echo "${GRE}${RED}...................:${WHI}"
echo "${GRE}Logged in users${RED}....:${WHI} ${VAR_USERS}"
echo ""
