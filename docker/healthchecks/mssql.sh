#!/bin/bash
# chmod +x

set -eo pipefail

sqlcmd -S localhost -U sa -P "${MSSQL_SA_PASSWORD}" -Q "SELECT getdate()" -b || exit 1
