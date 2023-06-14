#!/bin/sh
# This script performs the health check logic for dependency availability

# Check if Database service is available
if pg_isready -h localhost -p 5432 >/dev/null; then
  echo "Database service is available"
else
  echo "Database service is not available"
  exit 1
fi

# Check if Redis service is available
if redis-cli ping >/dev/null; then
  echo "Redis service is available"
else
  echo "Redis service is not available"
  exit 1
fi

# Check if RabbitMQ service is available
if rabbitmqctl await_startup >/dev/null; then
  echo "RabbitMQ service is available"
else
  echo "RabbitMQ service is not available"
  exit 1
fi

# Check if External API is available
if curl --silent --head --fail https://api.example.com >/dev/null; then
  echo "External API is available"
else
  echo "External API is not available"
  exit 1
fi

#!/bin/sh
# This script performs the health check logic for service availability

# Check if HTTP service is available
if curl --silent --head --fail http://localhost:80 >/dev/null; then
  echo "HTTP service is available"
else
  echo "HTTP service is not available"
  exit 1
fi

# Check if SSH service is available
if nc -z -w5 localhost 22; then
  echo "SSH service is available"
else
  echo "SSH service is not available"
  exit 1
fi

# Check if Database service is available
if nc -z -w5 localhost 3306; then
  echo "Database service is available"
else
  echo "Database service is not available"
  exit 1
fi

# Check if SMTP service is available
if nc -z -w5 localhost 25; then
  echo "SMTP service is available"
else
  echo "SMTP service is not available"
  exit 1
fi

# Check if DNS service is available
if nc -z -w5 localhost 53; then
  echo "DNS service is available"
else
  echo "DNS service is not available"
  exit 1
fi

# No service availability issues detected
echo "All services are available"
exit 0

