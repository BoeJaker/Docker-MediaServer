#!/bin/sh
# This script performs the health check logic for resource exhaustion

# Check CPU usage
cpu_threshold=90.0
cpu_usage=$(top -bn1 | awk '/^%Cpu/ {print $2}')
if (( $(echo "$cpu_usage > $cpu_threshold" | bc -l) )); then
  echo "High CPU usage detected: $cpu_usage%"
  exit 1
fi

# Check memory usage
memory_threshold=90.0
memory_usage=$(free | awk '/Mem:/ {print $3/$2 * 100}')
if (( $(echo "$memory_usage > $memory_threshold" | bc -l) )); then
  echo "High memory usage detected: $memory_usage%"
  exit 1
fi

# Check disk usage
disk_threshold=90.0
disk_usage=$(df -h --output=pcent / | awk 'NR==2 {print substr($0, 1, length($0)-1)}')
if (( $(echo "$disk_usage > $disk_threshold" | bc -l) )); then
  echo "High disk usage detected: $disk_usage%"
  exit 1
fi

# Check network bandwidth usage
network_threshold=90.0
network_usage=$(ifstat -b -i eth0 1 1 | tail -n 1 | awk '{print $1}')
if (( $(echo "$network_usage > $network_threshold" | bc -l) )); then
  echo "High network bandwidth usage detected: $network_usage bps"
  exit 1
fi

# No resource exhaustion detected
echo "No resource exhaustion detected"
exit 0
