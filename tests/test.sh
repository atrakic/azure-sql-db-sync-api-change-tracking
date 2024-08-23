#!/bin/bash
# chmod +x
set -eo pipefail

steps=$(( ( RANDOM % 10000 )  + 1 ))
distance=$(( ( RANDOM % 10000 )  + 1 ))
date=$(date +"%Y-%m-%d %T")

docker exec -it db sqlcmd \
    -S localhost -U sa -P "${MSSQL_SA_PASSWORD}" \
    -Q "SET NOCOUNT ON; update demo.dbo.TrainingSessions set Distance='$distance',Steps='$steps',RecordedOn='$date' where Id=3;" -b

curl -H "fromVersion: 0" localhost:5000/api/v1/training-session/sync
