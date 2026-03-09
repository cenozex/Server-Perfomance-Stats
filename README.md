# 📊 server-stats.sh

> A lightweight, zero-dependency Bash script that delivers a beautifully formatted snapshot of your Linux server's health — right in the terminal.

![Bash](https://img.shields.io/badge/Language-Bash-4EAA25?style=flat-square&logo=gnubash&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Linux-FCC624?style=flat-square&logo=linux&logoColor=black)
![Version](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)

---

## 📸 Preview

```
╔════════════════════════════════════════════════════╗
║         SERVER PERFORMANCE STATS REPORT            ║
╚════════════════════════════════════════════════════╝
Generated: 2026-xx-xx 20:29:11 +05xx

   System Information
───────────────────────────────────────────────────
 HOSTNAME:            your_hostname
 OS:                  Ubuntu 24.04.4 LTS
 KERNEL:              6.17.0-14-generic
 ARCHITECTURE:        x86_64
 UPTIME:              up x hour, x minutes
 LOAD AVERAGE:        0.xx, 0.xx, 0.xx

   CPU USAGE
───────────────────────────────────────────────────
  Model:               AMD Ryzen 7 8845HS w/ Radeon 780M Graphics
  Cores:               16
  Usage:               6.4%
                       [███░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░]

   MEMORY USAGE
───────────────────────────────────────────────────
  Total:               15288 MB
  Used:                4171 MB
  Free:                9117 MB
  Available:           11115 MB
  Usage %:             27.3%
                       [█████████████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░]

  Swap:                9742 MB total, 0 MB used (0.0%)

   DISK USAGE
───────────────────────────────────────────────────
  Filesystem                   Total     Used     Free   Use%
───────────────────────────────────────────────────
  /dev/nvme0n1p5                 76G      17G      55G    23%  /
  /dev/nvme0n1p1                196M      38M     159M    19%  /boot/efi
  /dev/nvme0n1p6                162G     8.8G     144G     6%  /home

   TOP 5 PROCESSES BY CPU USAGE
───────────────────────────────────────────────────
  PID      Name                   CPU%     MEM%     Command
───────────────────────────────────────────────────
  5861     /usr/bin/firefox       7.9      4.2      /usr/bin/firefox
  6119     /usr/lib/firefox/firefox-bin 3.3      2.7      /usr/lib/firefox/firefox-bin -contentproc -isFo...
  4087     /usr/bin/gnome-shell   2.5      2.8      /usr/bin/gnome-shell
  5248     /usr/share/code/code   2.3      2.2      /usr/share/code/code --type=zygote
  6039     /usr/lib/firefox/firefox-bin 1.7      2.1      /usr/lib/firefox/firefox-bin -contentproc -isFo...

   TOP 5 PROCESSES BY MEMORY USAGE
───────────────────────────────────────────────────
  PID      Name                   MEM%     CPU%     Command
───────────────────────────────────────────────────
  5861     /usr/bin/firefox       4.2      7.9      /usr/bin/firefox
  6148     /usr/lib/firefox/firefox-bin 2.9      0.9      /usr/lib/firefox/firefox-bin -contentproc -isFo...
  4087     /usr/bin/gnome-shell   2.8      2.5      /usr/bin/gnome-shell
  5349     /proc/self/exe         2.7      0.7      /proc/self/exe --type=utility --utility-sub-typ...
  6119     /usr/lib/firefox/firefox-bin 2.7      3.3      /usr/lib/firefox/firefox-bin -contentproc -isFo...

   LOGGED IN USERS
───────────────────────────────────────────────────
  Active sessions: 2

  your_username       seat0      2026-03-09 19:40
  your_username       :1         2026-03-09 19:40

   FAILED LOGIN ATTEMPTS (last 10)
───────────────────────────────────────────────────
  Total failed attempts: 0
0


   NETWORK INTERFACES
───────────────────────────────────────────────────
  lo              UNKNOWN      127.0.0.1/x
  enp3s0          DOWN         
  wlp4s0          UP           192.168.x.xx/xx
  docker0         DOWN         172.xx.x.x/xx

╔════════════════════════════════════════════════════╗
║                  END OF REPORT                     ║
╚════════════════════════════════════════════════════╝
```

---

## ✨ Features

| Feature | Description |
|---|---|
| 🖥️ **System Info** | OS name, kernel version, hostname, architecture, uptime, load average |
| ⚙️ **CPU Usage** | Model, core count, real-time usage % with a live visual progress bar |
| 🧠 **Memory Usage** | Total, used, free, available RAM in MB + usage % with progress bar |
| 💾 **Swap Usage** | Total, used, and free swap space with percentage |
| 📀 **Disk Usage** | Per-partition breakdown with colour-coded usage warnings |
| 🔝 **Top 5 by CPU** | Sorted process table showing PID, name, CPU%, MEM%, and command |
| 🔝 **Top 5 by MEM** | Same table sorted by memory consumption |
| 👤 **Logged-in Users** | Active session count with user, terminal, and login time |
| 🔐 **Failed Logins** | Total count + last 10 failed SSH/login attempts from system logs |
| 🌐 **Network Interfaces** | All interfaces with their status and IP addresses |
| 🎨 **Colour Coding** | Disk usage highlighted green / yellow / red based on thresholds |

---

## 🚀 Quick Start

### clone the repository:

```bash
git clone https://github.com/cenozex/Server-Perfomance-Stats.git
cd server-stats
```

### 2. Make it executable

```bash
chmod +x server-stats.sh
```

### 3. Run it

```bash
./server-stats.sh
```

For full access to auth logs (failed login attempts), run with `sudo`:

```bash
sudo ./server-stats.sh
```

---

## 🛠️ Requirements

This script uses only standard Linux utilities — no installation needed.

| Tool | Purpose | Pre-installed on |
|---|---|---|
| `bash` | Script interpreter | All Linux distros |
| `top` | CPU usage stats | All Linux distros |
| `free` | Memory and swap stats | All Linux distros |
| `df` | Disk usage stats | All Linux distros |
| `ps` | Process list | All Linux distros |
| `who` | Logged-in users | All Linux distros |
| `uname` | Kernel and OS info | All Linux distros |
| `awk` | Text processing | All Linux distros |
| `grep` | Pattern matching | All Linux distros |
| `ip` / `ifconfig` | Network interfaces | Most Linux distros |

> ✅ No `pip install`, no `apt install`, no dependencies. Works out of the box on any standard Linux server.

---

## 🐧 Compatibility

Tested and working on the following distributions:

| Distribution | Status |
|---|---|
| Ubuntu 20.04 / 22.04 / 24.04 | ✅ Fully supported |
| Debian 11 / 12 | ✅ Fully supported |
| CentOS 7 / 8 | ✅ Fully supported |
| Rocky Linux 8 / 9 | ✅ Fully supported |
| AlmaLinux 8 / 9 | ✅ Fully supported |
| Fedora 38+ | ✅ Fully supported |
| Amazon Linux 2 | ✅ Fully supported |
| Arch Linux | ✅ Fully supported |

---

## 📋 Output Sections Explained

### 🖥️ System Information
Displays the machine's hostname, full OS name, kernel version, CPU architecture, how long the server has been running, and the 1/5/15-minute load averages.

### ⚙️ CPU Usage
Shows the CPU model and core count, then calculates real-time CPU usage by reading idle time from `top`. A 50-character progress bar gives an instant visual read of load.

### 🧠 Memory Usage
Reads from `free -m` to show total, used, free, and available RAM in megabytes, along with a percentage and progress bar. Also shows swap space stats separately.

### 📀 Disk Usage
Uses `df -h` to list all real disk partitions (filters out virtual filesystems). The usage percentage column is colour-coded:

- 🟢 **Green** — under 70% used (healthy)
- 🟡 **Yellow** — 70–89% used (getting full)
- 🔴 **Red** — 90%+ used (critical)

### 🔝 Top 5 Processes (CPU & Memory)
Uses `ps aux` sorted by CPU% and MEM% respectively. Long command strings are automatically truncated to 50 characters with `...` to keep the table readable.

### 👤 Logged-in Users
Uses `who` to list all active sessions — useful for spotting unexpected logins on a production server.

### 🔐 Failed Login Attempts
Reads `/var/log/auth.log` (Ubuntu/Debian) or `/var/log/secure` (CentOS/RedHat) and shows the total count of failed password attempts plus the 10 most recent entries. Requires `sudo` for access.

### 🌐 Network Interfaces
Uses the modern `ip` command (with `ifconfig` as a fallback) to list all network interfaces, their up/down status, and assigned IP addresses.

---

## 💡 Usage Tips

**Run on a schedule with cron** — log the output to a file every hour:
```bash
0 * * * * /path/to/server-stats.sh >> /var/log/server-stats.log 2>&1
```

**Check a remote server over SSH:**
```bash
ssh user@your-server 'bash -s' < server-stats.sh
```

**Save a report to a file:**
```bash
./server-stats.sh > report-$(date +%F).txt
```

**Strip colours for a plain-text file:**
```bash
./server-stats.sh | sed 's/\x1b\[[0-9;]*m//g' > report.txt
```

---

## 📁 Project Structure

```
server-stats/
├── server-stats.sh      # Main script
└── README.md            # This file
```

---


## 👤 Author

Built with ❤️ for Linux sysadmins and developers who live in the terminal.

---

*If this script helped you, consider giving the repo a ⭐ on GitHub!*