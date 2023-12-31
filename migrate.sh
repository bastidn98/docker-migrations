#!/bin/bash
echo "Waiting for PostgreSQL to be ready..."
./wait-for-it.sh db:5432 -t 5

echo "Running migrations..."
DB=$PROD_DBNAME alembic -c /alembic.ini upgrade head
echo "Migrations completed."

PGPASSWORD=postgres psql -U postgres -h db -p 5432 -c "\dt" $DB
