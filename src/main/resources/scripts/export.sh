#!/bin/bash
set -e
echo "********************** IN EXPORT FILE TO EXPORT TABLE ($1) *********************"
export TABLE_NAME=$1
# Load environment variables
source "scripts/env.sh"
source "scripts/query.sh"



echo " *********** Table Name is ${TABLE_NAME} *************"

if [ -z "$TABLE_NAME" ]; then
  echo "Usage: $0 <table_name>"
  exit 1
fi

EXPORT_SQL="${EXPORT_DIR}/${TABLE_NAME}.csv"
PG_QUERY="COPY (${QUERY}) TO STDOUT WITH CSV QUOTE '\"' DELIMITER ',' HEADER;"

sqlite3 "$EXPORT_DIR/${TABLE_NAME}.sqlite" < "scripts/table.sql"

echo "🔹 Exporting table $TABLE_NAME from Postgres to $EXPORT_SQL ..."
# | sed 's/[[:space:]]*|[[:space:]]*/","/g'
#dbsql --engine pg_engine --sql "${QUERY}" | sed 's/[[:space:]]*|[[:space:]]*/,/g; s/null//g; s/^* //; s/ *$//' > "${EXPORT_SQL}"
psql "$PSQL_URL" -c "$PG_QUERY" > "${EXPORT_SQL}"
#sed -i "$ d" "${EXPORT_DIR}/${TABLE_NAME}.csv"
#
echo "🔹 Importing into SQLite $EXPORT_DIR/${TABLE_NAME}.sqlite ..."
#sqlite3 "$EXPORT_DIR/${TABLE_NAME}.sqlite" < "${EXPORT_SQL}"
dbimport --engine sqlite_engine \
  --format CSV \
  --table "$TABLE_NAME" \
   "$EXPORT_DIR/$TABLE_NAME.csv"

echo "Done. File saved at: $EXPORT_DIR/${TABLE_NAME}.sqlite"
cd $EXPORT_DIR
ls -l
