#!/bin/bash
set -e

# Load environment variables
source "scripts/env.sh"

TABLE_NAME=$1

echo " *********** Table Name is ${TABLE_NAME} *************"

if [ -z "$TABLE_NAME" ]; then
  echo "Usage: $0 <table_name>"
  exit 1
fi

EXPORT_SQL="$EXPORT_DIR/${TABLE_NAME}.sql"
SQLITE_FILE="$EXPORT_DIR/${TABLE_NAME}.sqlite"

sqlite3 "$EXPORT_DIR/${TABLE_NAME}.sqlite" < "scripts/table.sql"

echo "🔹 Exporting table $TABLE_NAME from H2 to $EXPORT_SQL ..."
$SYM_HOME/bin/dbexport \
  --engine=h2_engine \
  --format=sql \
  --compatible=sqlite \
  --sql="SELECT * FROM $TABLE_NAME" \
  $TABLE_NAME > "$EXPORT_SQL"

  echo "🔹 Importing into SQLite $SQLITE_FILE ..."
  $SYM_HOME/bin/dbimport \
    --engine=sqlite_engine \
    --format=sql \
     --force \
    "$EXPORT_SQL"

echo "✅ Done. File saved at: $SQLITE_FILE"
