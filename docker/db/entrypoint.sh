#!/usr/bin/env bash
#start SQL Server, start the script to create/setup the DB
set -m

./db-init.sh &

# Startup the actual SQL Server process
./opt/mssql/bin/sqlservr

fg
