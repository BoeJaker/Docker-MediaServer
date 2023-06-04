#!/bin/bash

# Get the network range from ifconfig
network_range=$(ifconfig | grep -oE 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | awk '{print $2}')

# Perform the network scan
scan_results=$(nmap -p 5900 "$network_range" -oG - | grep "5900/open")

# Extract the IP addresses of hosts with open VNC ports
host_ips=$(echo "$scan_results" | awk '{print $2}')

# Display the available hosts
echo "Available hosts with VNC:"
echo "$host_ips"

# Prompt the user to select a host
read -p "Select a host by entering the corresponding index: " host_index

# Validate the user's input
if [[ $host_index =~ ^[0-9]+$ ]]; then
  # Extract the selected host IP based on the index
  selected_host=$(echo "$host_ips" | sed -n "${host_index}p")

  # Set the display environment variable for the VNC container
  export DISPLAY="$selected_host:0"
  echo "Selected host: $selected_host"

  # Start the VNC server on the selected host
  x11vnc -display "$DISPLAY" -forever -usepw -shared -rfbport 5900 &
else
  echo "Invalid input. Please enter a valid index."
fi
