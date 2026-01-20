#!/bin/bash

CONTAINER_NAME="${1:-devops-demo-app}"
HEALTH_ENDPOINT="${2:-http://localhost:5000/health}"
TIMEOUT=5

if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "CRITICAL: Container ${CONTAINER_NAME} not running"
    exit 2
fi

response=$(curl -s -o /dev/null -w "%{http_code}" --max-time "$TIMEOUT" "$HEALTH_ENDPOINT" 2>/dev/null)

if [ "$response" -eq 200 ]; then
    echo "OK: ${CONTAINER_NAME} is healthy"
    exit 0
else
    echo "WARNING: ${CONTAINER_NAME} returned HTTP ${response}"
    exit 1
fi
