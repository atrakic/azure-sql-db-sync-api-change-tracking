#!/bin/bash
# chmod +x
set -eo pipefail

SCRIPT_ROOT=$(dirname "${BASH_SOURCE[0]}")
source "${SCRIPT_ROOT}"/../.env

# Updates a training session with random values
declare -a activity
activity=("running" "cycling" "swimming")
type=${activity[$RANDOM % ${#activity[@]}]}
steps=$(( ( RANDOM % 10000 )  + 1 ))
distance=$(( ( RANDOM % 10000 )  + 1 ))
date=$(date +"%Y-%m-%d %T")
id=$(( ( RANDOM % 3 )  + 1 ))

echo "Updating training session id: $id with steps: $steps, distance: $distance, date: $date, type: $type"
docker exec -it db sqlcmd \
    -S localhost -U sa -P "${MSSQL_SA_PASSWORD}" \
    -Q "SET NOCOUNT ON; update demo.dbo.TrainingSessions set Type='$type',Distance='$distance',Steps='$steps',RecordedOn='$date' where Id=$id;" -b

# Gets all training sessions
curl -s -H "fromVersion: 0" localhost:5000/api/v1/training-session/sync | jq -r "." # python3 -m json.tool
