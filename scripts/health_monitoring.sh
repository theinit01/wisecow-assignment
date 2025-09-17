#!/bin/bash

CPU_THRESHOLD=80
MEM_THRESHOLD=80 
DISK_THRESHOLD=80
PROCESS_THRESHOLD=200 


LOG_FILE="/var/log/system_health.log"

log_alert() {
    local message="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') ALERT: $message" | tee -a "$LOG_FILE"
}


cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2 + $4)}')
if [ "$cpu_usage" -gt "$CPU_THRESHOLD" ]; then
    log_alert "High CPU Usage: ${cpu_usage}%"
fi


mem_usage=$(free | awk '/Mem:/ {printf("%d", $3/$2 * 100)}')
if [ "$mem_usage" -gt "$MEM_THRESHOLD" ]; then
    log_alert "High Memory Usage: ${mem_usage}%"
fi


disk_usage=$(df -h / | awk 'NR==2 {print int($5)}')
if [ "$disk_usage" -gt "$DISK_THRESHOLD" ]; then
    log_alert "High Disk Usage on /: ${disk_usage}%"
fi


process_count=$(ps aux --no-heading | wc -l)
if [ "$process_count" -gt "$PROCESS_THRESHOLD" ]; then
    log_alert "High Number of Processes: ${process_count}"
fi
