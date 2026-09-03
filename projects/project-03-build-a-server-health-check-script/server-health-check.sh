#!/bin/bash

# ========================================

# Server Health Check Script

# ========================================

# Overall server status

OVERALL_STATUS="HEALTHY"

# Threshold values

CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80

# ========================================

# Function: Check CPU Usage

# ========================================

get_cpu_usage() {

```
# Read first CPU values
read cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat

IDLE1=$((idle + iowait))

TOTAL1=$((user + nice + system + idle + iowait + irq + softirq + steal))

# Wait for 1 second
sleep 1

# Read second CPU values
read cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat

IDLE2=$((idle + iowait))

TOTAL2=$((user + nice + system + idle + iowait + irq + softirq + steal))

# Calculate differences
IDLE_DIFF=$((IDLE2 - IDLE1))

TOTAL_DIFF=$((TOTAL2 - TOTAL1))

# Calculate CPU usage
if (( TOTAL_DIFF > 0 )); then

    CPU_USAGE=$((100 * (TOTAL_DIFF - IDLE_DIFF) / TOTAL_DIFF))

else

    CPU_USAGE=0

fi
```

}

# ========================================

# SERVER INFORMATION

# ========================================

echo ""
echo "========================================"
echo "        SERVER HEALTH CHECK"
echo "========================================"

echo "Hostname : $(hostname)"

echo "OS       : $(grep '^PRETTY_NAME=' /etc/os-release | cut -d '"' -f2)"

echo "Date     : $(date)"

echo "Uptime   : $(uptime -p)"

# ========================================

# CPU HEALTH CHECK

# ========================================

echo ""
echo "----------------------------------------"
echo "CPU HEALTH CHECK"
echo "----------------------------------------"

CPU_CORES=$(nproc)

get_cpu_usage

echo "CPU Cores  : $CPU_CORES"

echo "CPU Usage  : ${CPU_USAGE}%"

if (( CPU_USAGE >= CPU_THRESHOLD )); then

```
echo "CPU Status : WARNING"

OVERALL_STATUS="WARNING"
```

else

```
echo "CPU Status : OK"
```

fi

# ========================================

# MEMORY HEALTH CHECK

# ========================================

echo ""
echo "----------------------------------------"
echo "MEMORY HEALTH CHECK"
echo "----------------------------------------"

# Get total memory

TOTAL_MEMORY=$(free -h | awk '/Mem:/ {print $2}')

# Get used memory

USED_MEMORY=$(free -h | awk '/Mem:/ {print $3}')

# Calculate memory usage percentage

MEMORY_USAGE=$(free | awk '/Mem:/ {printf "%.0f", ($3/$2)*100}')

echo "Total Memory : $TOTAL_MEMORY"

echo "Used Memory  : $USED_MEMORY"

echo "Memory Usage : ${MEMORY_USAGE}%"

if (( MEMORY_USAGE >= MEMORY_THRESHOLD )); then

```
echo "Memory Status : WARNING"

OVERALL_STATUS="WARNING"
```

else

```
echo "Memory Status : OK"
```

fi

# ========================================

# DISK HEALTH CHECK

# ========================================

echo ""
echo "----------------------------------------"
echo "DISK HEALTH CHECK"
echo "----------------------------------------"

# Get disk usage of root filesystem

DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

echo "Filesystem : /"

echo "Disk Usage : ${DISK_USAGE}%"

if (( DISK_USAGE >= DISK_THRESHOLD )); then

```
echo "Disk Status : WARNING"

OVERALL_STATUS="WARNING"
```

else

```
echo "Disk Status : OK"
```

fi

# ========================================

# TOP CPU PROCESSES

# ========================================

echo ""
echo "----------------------------------------"
echo "TOP 5 CPU CONSUMING PROCESSES"
echo "----------------------------------------"

ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -6

# ========================================

# TOP MEMORY PROCESSES

# ========================================

echo ""
echo "----------------------------------------"
echo "TOP 5 MEMORY CONSUMING PROCESSES"
echo "----------------------------------------"

ps -eo pid,comm,%mem,%cpu --sort=-%mem | head -6

# ========================================

# NETWORK HEALTH CHECK

# ========================================

echo ""
echo "----------------------------------------"
echo "NETWORK HEALTH CHECK"
echo "----------------------------------------"

# Internet connectivity

if ping -c 2 -W 2 8.8.8.8 > /dev/null 2>&1; then

```
echo "Internet Status : PASS"
```

else

```
echo "Internet Status : FAIL"

OVERALL_STATUS="WARNING"
```

fi

# DNS resolution

if getent hosts google.com > /dev/null 2>&1; then

```
echo "DNS Status      : PASS"
```

else

```
echo "DNS Status      : FAIL"

OVERALL_STATUS="WARNING"
```

fi

# ========================================

# SERVICE HEALTH CHECK

# ========================================

echo ""
echo "----------------------------------------"
echo "SERVICE HEALTH CHECK"
echo "----------------------------------------"

# Check SSH service

if systemctl list-unit-files | grep -q "^sshd.service"; then

```
if systemctl is-active --quiet sshd; then

    echo "SSH Service : RUNNING"

else

    echo "SSH Service : NOT RUNNING"

    OVERALL_STATUS="WARNING"

fi
```

else

```
echo "SSH Service : NOT INSTALLED"
```

fi

# ========================================

# IMPORTANT LISTENING PORTS

# ========================================

echo ""
echo "----------------------------------------"
echo "LISTENING PORTS"
echo "----------------------------------------"

ss -tuln

# ========================================

# OVERALL SERVER HEALTH

# ========================================

echo ""
echo "========================================"
echo "        OVERALL SERVER HEALTH"
echo "========================================"

echo "Server Status : $OVERALL_STATUS"

echo "========================================"
echo "       HEALTH CHECK COMPLETED"
echo "========================================"

echo ""
