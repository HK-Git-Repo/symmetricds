#!/bin/bash
set -e
echo "********************** IN EXPORT FILE TO EXPORT TABLE ($1) *********************"
# Load environment variables
source "scripts/env.sh"

export TABLE_NAME=$1

echo " *********** Table Name is ${TABLE_NAME} *************"

if [ -z "$TABLE_NAME" ]; then
  echo "Usage: $0 <table_name>"
  exit 1
fi

EXPORT_SQL="$EXPORT_DIR/${TABLE_NAME}.csv"
SQLITE_FILE="$EXPORT_DIR/${TABLE_NAME}.sqlite"

sqlite3 "$EXPORT_DIR/${TABLE_NAME}.sqlite" < "scripts/table.sql"

echo "🔹 Exporting table $TABLE_NAME from Postgres to $EXPORT_SQL ..."
dbsql \
  --engine pg_engine \
  --format CSV \
  --sql "SELECT * FROM $TABLE_NAME" \
  $TABLE_NAME > "$EXPORT_SQL"

  echo "🔹 Importing into SQLite $SQLITE_FILE ..."
 dbimport \
    --engine=sqlite_engine \
    --format=CSV \
    "$EXPORT_SQL"

echo "✅ Done. File saved at: $SQLITE_FILE"
