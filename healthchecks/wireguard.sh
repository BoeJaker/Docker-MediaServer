#!/bin/sh
# This script performs the health check logic for WireGuard connection

# Specify the name of the WireGuard interface
wg_interface="$1"

# Check the WireGuard connection status using the `wg` command
if wg show "$wg_interface" &> /dev/null; then
  exit 0  # WireGuard connection is properly connected
else
  exit 1  # WireGuard connection is not connected
fi