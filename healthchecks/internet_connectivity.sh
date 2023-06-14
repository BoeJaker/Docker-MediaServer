#!/bin/sh
# This script performs the health check logic for external connectivity

# Specify the URL to check connectivity
url="$1"

# Check external connectivity by sending an HTTP GET request
if curl --head --silent --fail "$url" > /dev/null; then
  exit 0  # External connectivity is available
else
  exit 1  # External connectivity is not available
fi
