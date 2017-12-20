#!/bin/bash

 # === db login credentials
host="172.31.20.48";
username="it610";
password="njit";
db="git";

# mysql --user="it610" --host="172.31.20.48" --password="njit" --database="git" --execute='SELECT * FROM backup';
# INSERT INTO `backup`(`id`, `filename`, `time`) VALUES ("1513005372","backup_1513005372", "1513005372")

id=$(date "+%s")
filename=$(date "+backup_%s")
timestamp=$(date)

# === 7
oldid=$(date -d "now -7 days" +%s)
old_filename="backup_"$oldid
olddate7=$(date -d 'now - 7 days')
sql_add_entry="INSERT INTO backup(id, filename, time) VALUES ('$oldid','$old_filename', '$olddate7')"
mysql --user="it610" --host="172.31.20.48" --password="njit" --database="git" --execute="$sql_add_entry";

# === 6
oldid=$(date -d "now -6 days" +%s)
old_filename="backup_"$oldid
olddate7=$(date -d 'now - 6 days')
sql_add_entry="INSERT INTO backup(id, filename, time) VALUES ('$oldid','$old_filename', '$olddate7')"
mysql --user="it610" --host="172.31.20.48" --password="njit" --database="git" --execute="$sql_add_entry";

# === 5
oldid=$(date -d "now -5 days" +%s)
old_filename="backup_"$oldid
olddate7=$(date -d 'now - 5 days')
sql_add_entry="INSERT INTO backup(id, filename, time) VALUES ('$oldid','$old_filename', '$olddate7')"
mysql --user="it610" --host="172.31.20.48" --password="njit" --database="git" --execute="$sql_add_entry";

# === 4
oldid=$(date -d "now -4 days" +%s)
old_filename="backup_"$oldid
olddate7=$(date -d 'now - 4 days')
sql_add_entry="INSERT INTO backup(id, filename, time) VALUES ('$oldid','$old_filename', '$olddate7')"
mysql --user="it610" --host="172.31.20.48" --password="njit" --database="git" --execute="$sql_add_entry";

# === 3
oldid=$(date -d "now -3 days" +%s)
old_filename="backup_"$oldid
olddate7=$(date -d 'now - 3 days')
sql_add_entry="INSERT INTO backup(id, filename, time) VALUES ('$oldid','$old_filename', '$olddate7')"
mysql --user="it610" --host="172.31.20.48" --password="njit" --database="git" --execute="$sql_add_entry";

# === 2
oldid=$(date -d "now -2 days" +%s)
old_filename="backup_"$oldid
olddate7=$(date -d 'now - 2 days')
sql_add_entry="INSERT INTO backup(id, filename, time) VALUES ('$oldid','$old_filename', '$olddate7')"
mysql --user="it610" --host="172.31.20.48" --password="njit" --database="git" --execute="$sql_add_entry";

# === 1
oldid=$(date -d "now -1 days" +%s)
old_filename="backup_"$oldid
olddate7=$(date -d 'now - 1 days')
sql_add_entry="INSERT INTO backup(id, filename, time) VALUES ('$oldid','$old_filename', '$olddate7')"
mysql --user="it610" --host="172.31.20.48" --password="njit" --database="git" --execute="$sql_add_entry";






