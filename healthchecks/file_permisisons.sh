#!/bin/sh
# This script performs the health check logic

# Check the file permissions of the specific file or directory
file_path="$1"
permissions="$2"


  if ! [ -r "$file_path" ] && [ "r" =~ permissions]; then
    exit 1  # File permissions are incorrect
    fi
  if ! [ -w "$file_path" ] && [ "w" =~ permissions]; then
    exit 1  # File permissions are incorrect
    fi
  if ! [ -x "$file_path" ] && [ "x" =~ permissions]; then
    exit 1  # File permissions are incorrect
    fi
else
  exit 1  # File permissions are incorrect
fi
exit 0  # File has the necessary read, write, and execute permissions