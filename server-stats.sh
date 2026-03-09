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


#CPU USAGE

header "CPU USAGE"

CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | tr -d '%id,')
#top is a basic and classic linux process monitoring tool.
#For different top format

if [ -z "$CPU_IDLE" ]; then
CPU_IDLE=$(top -bn1 | grep "%Cpu" | awk '{print $8}')
fi

CPU_USED=$(awk "BEGIN {printf \"%.1f\", 100 - ${CPU_IDLE:-0}}")
CPU_CORES=$(nproc 2>/dev/null || grep -c ^processor /proc/cpuinfo)
CPU_MODEL=$(grep "model name" /proc/cpuinfo | head -1 | cut -d: -f2 | xargs)

printf "  %-20s %s\n" "Model:"    "$CPU_MODEL"
printf "  %-20s %s\n" "Cores:"    "$CPU_CORES"
printf "  %-20s ${RED}%s%%${RESET}\n" "Usage:" "$CPU_USED"


# Visual bar -> To get clear view of memory in the form of bar
BAR_FILLED=$(awk "BEGIN {printf \"%d\", ${CPU_USED}/2}")
BAR_EMPTY=$((50 - BAR_FILLED))
printf "  %-20s [" ""; 
printf "${RED}%0.s█${RESET}" $(seq 1 $BAR_FILLED) 2>/dev/null
printf "%0.s░" $(seq 1 $BAR_EMPTY) 2>/dev/null
echo "]"
echo ""



# ── MEMORY USAGE ──────────────────────────────────────
header "MEMORY USAGE"

MEM_TOTAL=$(free -m | awk '/^Mem:/{print $2}')
MEM_USED=$(free -m  | awk '/^Mem:/{print $3}')
MEM_FREE=$(free -m  | awk '/^Mem:/{print $4}')
MEM_AVAIL=$(free -m | awk '/^Mem:/{print $7}')
MEM_PCT=$(awk "BEGIN {printf \"%.1f\", ($MEM_USED/$MEM_TOTAL)*100}")

SWAP_TOTAL=$(free -m | awk '/^Swap:/{print $2}')
SWAP_USED=$(free -m  | awk '/^Swap:/{print $3}')
SWAP_FREE=$(free -m  | awk '/^Swap:/{print $4}')
if [ "$SWAP_TOTAL" -gt 0 ]; then
  SWAP_PCT=$(awk "BEGIN {printf \"%.1f\", ($SWAP_USED/$SWAP_TOTAL)*100}")
else
  SWAP_PCT="0.0"
fi

printf "  %-20s %s MB\n"              "Total:"     "$MEM_TOTAL"
printf "  %-20s %s MB\n"              "Used:"      "$MEM_USED"
printf "  %-20s %s MB\n"              "Free:"      "$MEM_FREE"
printf "  %-20s %s MB\n"              "Available:" "$MEM_AVAIL"
printf "  %-20s ${RED}%s%%${RESET}\n" "Usage %:"   "$MEM_PCT"

BAR_FILLED=$(awk "BEGIN {printf \"%d\", ${MEM_PCT}/2}")
BAR_EMPTY=$((50 - BAR_FILLED))
printf "  %-20s [" ""
printf "${RED}%0.s█${RESET}" $(seq 1 $BAR_FILLED) 2>/dev/null
printf "%0.s░" $(seq 1 $BAR_EMPTY) 2>/dev/null
echo "]"

echo ""
printf "  %-20s %s MB total, %s MB used (%s%%)\n" "Swap:" "$SWAP_TOTAL" "$SWAP_USED" "$SWAP_PCT"
echo ""


# ── DISK USAGE ────────────────────────────────────────
header "DISK USAGE"

printf "  %-25s %8s %8s %8s %6s\n" "Filesystem" "Total" "Used" "Free" "Use%"
divider
df -h --output=source,size,used,avail,pcent,target 2>/dev/null \
  | grep -E '^/dev/' \
  | while read -r src size used avail pct mount; do
      PCT_NUM=${pct/\%/}
      if   [ "$PCT_NUM" -ge 90 ] 2>/dev/null; then COLOR=$RED
      elif [ "$PCT_NUM" -ge 70 ] 2>/dev/null; then COLOR=$YELLOW
      else COLOR=$GREEN; fi
      printf "  %-25s %8s %8s %8s ${COLOR}%6s${RESET}  %s\n" \
        "$src" "$size" "$used" "$avail" "$pct" "$mount"
    done
echo ""



# ── TOP 5 PROCESSES — CPU ─────────────────────────────
header "TOP 5 PROCESSES BY CPU USAGE"

printf "  %-8s %-22s %-8s %-8s %s\n" "PID" "Name" "CPU%" "MEM%" "Command"
divider
ps aux --sort=-%cpu 2>/dev/null \
  | awk 'NR>1 {
      cmd = substr($0, index($0,$11))
      if (length(cmd) > 50) cmd = substr(cmd, 1, 47) "..."
      printf "  %-8s %-22s %-8s %-8s %s\n", $2, $11, $3, $4, cmd
    }' \
  | head -5
echo ""

# ── TOP 5 PROCESSES — MEMORY ──────────────────────────
header "TOP 5 PROCESSES BY MEMORY USAGE"

printf "  %-8s %-22s %-8s %-8s %s\n" "PID" "Name" "MEM%" "CPU%" "Command"
divider
ps aux --sort=-%mem 2>/dev/null \
  | awk 'NR>1 {
      cmd = substr($0, index($0,$11))
      if (length(cmd) > 50) cmd = substr(cmd, 1, 47) "..."
      printf "  %-8s %-22s %-8s %-8s %s\n", $2, $11, $4, $3, cmd
    }' \
  | head -5
echo ""