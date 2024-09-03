#!/usr/bin/env bash
set -e

API_PORT=${API_PORT:-80}
HOST=${HOST:-api}

while true; do
  sleep_time=1
  version_id=$(curl -s -X 'GET' \
    -H 'accept: application/json' \
    http://"${HOST}":"${API_PORT}"/api/v1/training-session/sync | jq -r '.Metadata.Sync.Version')

  if [ "$version_id" != 0 ]; then
    version_id=$((version_id - 1))
    curl -s -H 'fromVersion: 0' -H 'accept: application/json' \
        http://"${HOST}":"${API_PORT}"/api/v1/training-session/sync/"$version_id" | jq -r '.'

    OurRecordedOn=$(date +"%Y-%m-%dT%H:%M:%SZ")
    TheirsRecordedOn=$(curl -s -H 'accept: application/json' \
        http://"${HOST}":"${API_PORT}"/api/v1/training-session/sync/"$version_id" | jq -r '.Data[].RecordedOn')
    if [ "$TheirsRecordedOn" == "$OurRecordedOn" ]; then
        echo "TODO: Sending the diff data to the queue"
    fi
  fi
  
  sleep "$sleep_time"
done
