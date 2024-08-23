#!/usr/bin/env bash
set -e
#set -o pipefail
  
API_PORT=${API_PORT:-80}
HOST=${HOST:-api}
SLEEP=5

while true; do
  
  id=$(( ( RANDOM % 10 )  + 1 ))

  curl -s -X 'GET' \
    -H 'accept: application/json' \
    http://"${HOST}":"${API_PORT}"/api/v1/training-session/sync/"$id" | jq -r
  sleep "$SLEEP"

done
