#!/usr/bin/env bash

for i in {1..50};
do
  sqlcmd -S localhost -U sa -P "${MSSQL_SA_PASSWORD}" -Q "SELECT getdate()" -b
  if [ $? -eq 0 ]
  then
      echo "Creating database"
      sqlcmd -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -d master -i create.sql
      sleep 1
      
      echo "Create procedure"
      sqlcmd -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -d master -i procedure.sql
      echo "Done with db procedure ..."
      sleep 1

      echo "Loading data"
      sqlcmd -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -d master -i data.sql
      echo "Done with db loading ..."
      break
  else
      echo "$i: Waiting for SQL Server to start..."
      sleep 1
  fi
done
