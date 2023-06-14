#!/bin/sh
# This script performs the health check logic for container's reachability

# Specify the container's port to check
container_port="$1"

# Check if the container's port is accessible
if nc -z -w5 0.0.0.0 "$container_port"; then
  exit 0  # Container is reachable from the outside
else
  exit 1  # Container is not reachable from the outside
fi
