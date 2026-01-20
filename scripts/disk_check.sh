#!/bin/bash

THRESHOLD=80
PARTITIONS=$(df -h --output=pcent,target | tail -n +2)

while IFS= read -r line; do
    usage=$(echo "$line" | awk '{print $1}' | tr -d '%')
    mount=$(echo "$line" | awk '{print $2}')
    
    if [ "$usage" -ge "$THRESHOLD" ]; then
        echo "ALERT: $mount is ${usage}% full"
        exit 1
    fi
done <<< "$PARTITIONS"

echo "OK: All partitions below ${THRESHOLD}%"
exit 0
