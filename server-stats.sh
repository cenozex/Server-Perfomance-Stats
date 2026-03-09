#!/usr/bin/env bash

#This is an server performance stats script using only bash which uses basic tools from linux like awk, grep, 

#Color Codes Section

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36'
BOLD='\033[1m'
RESET='\033[0m'


divider()
{
    echo -e "${CYAN}────────────────────────────────────────────────────${RESET}"
}

header()
{
    echo -e "${BOLD}${YELLOW}   $1${RESET}"
    divider
}

echo ""
echo -e "${BOLD}${GREEN}╔════════════════════════════════════════════════════╗${RESET}" 
echo -e "${BOLD}${GREEN}║         SERVER PERFORMANCE STATS REPORT            ║${RESET}" 
echo -e "${BOLD}${GREEN}╚════════════════════════════════════════════════════╝${RESET}" 
echo -e "Generated: $(date '+%Y-%m-%d %H:%M:%S %z')"
echo ""
#The box symbol here is unicode line drawing character or box drawing character
#Both code or direct symbol can be used.


#OS and System Info

header "System Information"

if [ -f /etc/os-release ]; then
    OS_NAME=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
    else
    OS_NAME=$(uname -s)
    fi

KERNEL=$(uname -r)
HOSTNAME=$(hostname)
ARCH=$(uname -m)
UPTIME=$(uptime -p 2>/dev/null || uptime)
LOAD=$(uptime | awk -F'load average:' '{print $2}' | xargs)


printf " %-20s %s\n" "HOSTNAME:"        "$HOSTNAME"
printf " %-20s %s\n" "OS:"              "$OS_NAME"
printf " %-20s %s\n" "KERNEL:"          "$KERNEL"
printf " %-20s %s\n" "ARCHITECTURE:"    "$ARCH"
printf " %-20s %s\n" "UPTIME:"          "$UPTIME"
printf " %-20s %s\n" "LOAD AVERAGE:"    "$LOAD"