#!/bin/bash
# Coach Hub database backup — Neon PostgreSQL
# Run manually any time, or automatically via launchd
# Connection string stored in ~/.config/p2a/secrets (never committed to git)

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
BACKUP_DIR="$HOME/Backups/databases"
LOG="$HOME/scripts/backup_neon_db.log"
DATE=$(date +%Y%m%d)
FILE="$BACKUP_DIR/coach-hub-$DATE.sql"

source ~/.config/p2a/secrets

mkdir -p "$BACKUP_DIR"
echo "$(date '+%Y-%m-%d %H:%M:%S') — Starting backup" >> "$LOG"

pg_dump "$DATABASE_URL" > "$FILE"

if [ $? -eq 0 ]; then
  SIZE=$(du -sh "$FILE" | cut -f1)
  echo "$(date '+%Y-%m-%d %H:%M:%S') — Backup complete: $FILE ($SIZE)" >> "$LOG"
  echo "✓ Backup saved: $FILE ($SIZE)"
else
  echo "$(date '+%Y-%m-%d %H:%M:%S') — Backup FAILED" >> "$LOG"
  echo "✗ Backup failed — check $LOG"
fi

# Keep only last 6 backups
ls -t "$BACKUP_DIR"/coach-hub-*.sql 2>/dev/null | tail -n +7 | xargs rm -f
