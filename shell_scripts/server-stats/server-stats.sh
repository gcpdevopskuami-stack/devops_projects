#!/bin/bash

# Function to display a header
print_header() {
    echo -e "\n========================================"
    echo -e "$1"
    echo -e "========================================\n"
}

print_header "Server Performance Stats"

# 1. Total CPU Usage
# Using 'top' to grab idle percentage and subtracting from 100
cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8 "%"}')
echo "Total CPU Usage: ${cpu_idle}%"

# 2. Total Memory Usage
print_header "Memory Usage"
free -m | awk 'NR==2{printf "Memory Used: %sMB | Memory Free: %sMB | Usage: %.2f%%\n", $3, $4, $3*100/$2}'

# 3. Total Disk Usage
print_header "Disk Usage"
df -h --total | grep 'total' | awk '{printf "Used: %s | Free: %s | Usage: %s\n", $3, $4, $5}'

# 4. Top 5 Processes by CPU Usage
print_header "Top 5 Processes by CPU Usage"
ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6

# 5. Top 5 Processes by Memory Usage
print_header "Top 5 Processes by Memory Usage"
ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -n 6

echo -e "\n--- End of Report ---\n"