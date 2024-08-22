#!/bin/bash
# chmod +x
set -eo pipefail

curl -H "fromVersion: 0" localhost:5000/api/v1/training-session/sync

#id=$(( ( RANDOM % 10000 )  + 1 ))
#docker exec -it db /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "${MSSQL_SA_PASSWORD}" -Q "update dbo.TrainingSessions set Steps = $id where Id = 13" -b
