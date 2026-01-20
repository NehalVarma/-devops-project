#!/bin/bash

CONTAINER_NAME="${1:-devops-demo-app}"
HEALTH_ENDPOINT="${2:-http://localhost:5000/health}"
MAX_RETRIES=3
RETRY_DELAY=5

check_health() {
    response=$(curl -s -o /dev/null -w "%{http_code}" --max-time 5 "$HEALTH_ENDPOINT" 2>/dev/null)
    [ "$response" -eq 200 ]
}

restart_container() {
    echo "$(date): Restarting ${CONTAINER_NAME}"
    docker restart "$CONTAINER_NAME"
    sleep 10
}

for i in $(seq 1 $MAX_RETRIES); do
    if check_health; then
        echo "$(date): ${CONTAINER_NAME} is healthy"
        exit 0
    fi
    echo "$(date): Health check failed (attempt $i/$MAX_RETRIES)"
    sleep "$RETRY_DELAY"
done

restart_container

if check_health; then
    echo "$(date): ${CONTAINER_NAME} recovered after restart"
    exit 0
else
    echo "$(date): ${CONTAINER_NAME} still unhealthy after restart"
    exit 1
fi
