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

sql_add_entry="INSERT INTO backup(id, filename, time) VALUES ('$id','$filename', '$timestamp')"
mysql --user="it610" --host="172.31.20.48" --password="njit" --database="git" --execute="$sql_add_entry";


olddate=$(date -d 'now - 7 days' +%s)
echo $olddate

sql_del_entry="DELETE FROM `backup` WHERE id < $olddate"
mysql --user="it610" --host="172.31.20.48" --password="njit" --database="git" --execute="$sql_del_entry";

