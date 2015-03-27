#!/bin/bash

if [ -z ${BACKUP_PATH+x} ]
then
  BACKUP_PATH="/var/mysql-backup"
  echo ">> [CAUTION] No \$BACKUP_PATH specified - using default value"
fi

echo ">> Using \$BACKUP_PATH: $BACKUP_PATH"
mkdir -p "$BACKUP_PATH" &> /dev/null

DB_LIST=`echo "show databases;" | mysql --defaults-extra-file="$MYSQL_DEFAULTS_FILE" | tail -n +2`

echo ">> Backup of every single db"
for DB in $DB_LIST
do
	echo -n "  >> Backing up '$DB'... "
	mysqldump --defaults-extra-file="$MYSQL_DEFAULTS_FILE" $DB > "$BACKUP_PATH/mysql-backup_$DB.sql"
	echo "  >> '$DB' finished"
	echo ""
done

echo ">> Backup of complete sql server"
mysqldump --defaults-extra-file="$MYSQL_DEFAULTS_FILE" --all-databases > "$BACKUP_PATH/mysql-backup_all-databases.sql"