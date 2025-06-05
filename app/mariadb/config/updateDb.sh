#!/bin/sh

#ROOT_PASSWORD="cloud-1"
#USER_PASSWORD="cloud-1"
#DATABASE="cloud1Database"
#DB_USER="cloud-1-User"
#HOST="%"

commands1="ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}'; FLUSH PRIVILEGES;"

commands2="CREATE DATABASE IF NOT EXISTS ${DATABASE} DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ; CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${USER_PASSWORD}'; FLUSH PRIVILEGES ;"

commands3="GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%' IDENTIFIED BY '${USER_PASSWORD}' ; FLUSH PRIVILEGES ;"

echo "----------------launch mariadb--------------------"

RESULT=$(/usr/bin/mariadb -u root --password=${ROOT_PASSWORD} --skip-column-names -e "SHOW DATABASES LIKE '${DATABASE}'")

if [ "$RESULT" = "$DATABASE" ]; then
    echo "Database exists"
else
    echo "-----------------set root password----------------------"
    echo "${commands1}" | /usr/bin/mariadb -u root --password=${ROOT_PASSWORD}
    echo "---------------------------------------"

    echo "---------------remove anonymous user------------------------"
    echo "DELETE FROM mysql.user WHERE user = '' AND host <> 'localhost';" | /usr/bin/mariadb -u root --password=${ROOT_PASSWORD}
    echo "DROP USER IF EXISTS ''@'localhost';" | /usr/bin/mariadb -u root --password=${ROOT_PASSWORD}
    echo "FLUSH PRIVILEGES;" | /usr/bin/mariadb -u root --password=${ROOT_PASSWORD}
    echo "---- done ---------------------------------"

    echo "${commands2}" | /usr/bin/mariadb -u root --password=${ROOT_PASSWORD}
    echo "${commands3}" | /usr/bin/mariadb -u root --password=${ROOT_PASSWORD}
    echo "FLUSH PRIVILEGES ;" | /usr/bin/mariadb -u root --password=${ROOT_PASSWORD}

    echo "---------------------------------------"

    /usr/bin/mariadb -u root --password="${ROOT_PASSWORD}" ${DATABASE} < ./wplogindb.sql
fi

# Restart MariaDB as mysql user
pkill -9 mariadbd && mariadbd --datadir=/var/lib/mysql --user=mysql

#To export login info from db after first login in wordpress use this command then move it to mariadb/config
#docker exec mariadb /usr/bin/mysqldump -u root --password=${ROOT_PASSWORD} ${DATABASE} > wplogindb.sql

