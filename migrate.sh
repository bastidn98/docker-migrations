#!/bin/bash
echo "Waiting for PostgreSQL to be ready..."
./wait-for-it.sh postgres:5432 -t 30

echo "Running migrations..."
DB=$PROD_DBNAME alembic -c /alembic.ini upgrade head
echo "Migrations completed."

PGPASSWORD=postgres psql -U postgres -h postgres_container -p 5432 -c "\dt" devdb
