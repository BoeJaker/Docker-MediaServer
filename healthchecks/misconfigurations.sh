#!/bin/sh
# This script performs the health check logic for common misconfigurations

# Check if the system has a strong password policy
if grep -q "password\s*required\s*pam_pwquality.so" /etc/pam.d/common-password; then
  echo "Strong password policy configured"
else
  echo "Weak password policy detected"
  exit 1
fi

# Check if root login is disabled
if grep -q "^PermitRootLogin\s*no" /etc/ssh/sshd_config; then
  echo "Root login disabled"
else
  echo "Root login enabled"
  exit 1
fi

# Check if SSH password authentication is disabled
if grep -q "^PasswordAuthentication\s*no" /etc/ssh/sshd_config; then
  echo "SSH password authentication disabled"
else
  echo "SSH password authentication enabled"
  exit 1
fi

# Check if file permissions are secure for sensitive files
sensitive_files=(
  "/etc/passwd"
  "/etc/shadow"
  "/etc/sudoers"
)
for file in "${sensitive_files[@]}"; do
  if [ -r "$file" ] && [ "$(stat -c %a "$file")" -eq 600 ]; then
    echo "Secure file permissions for $file"
  else
    echo "Insecure file permissions detected for $file"
    exit 1
  fi
done

# Check if SSL/TLS protocols and cipher suites are properly configured
if grep -q "^\s*ssl_protocols\s" /etc/nginx/nginx.conf && grep -q "^\s*ssl_ciphers\s" /etc/nginx/nginx.conf; then
  echo "SSL/TLS protocols and cipher suites properly configured"
else
  echo "SSL/TLS protocols or cipher suites misconfigured"
  exit 1
fi

# No misconfigurations detected
echo "No misconfigurations detected"
exit 0
