#!/bin/sh

# Ensure /run/mysqld directory exists with correct permissions
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Ensure MariaDB configuration allows network connections
#mariadb by default listen to localhost
#sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
sed -i 's/^#datadir/datadir/' /etc/mysql/mariadb.conf.d/50-server.cnf
sed -i 's/^# port/port/' /etc/mysql/my.cnf
sed -i 's/^# port/port/' /etc/mysql/mariadb.cnf

# Initialize database if needed
if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "Initializing MariaDB data directory..."
  mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB as mysql user
echo "Starting MariaDB..."
mariadbd --datadir=/var/lib/mysql --user=mysql --socket=/run/mysqld/mysqld.sock &


# Wait for MariaDB to fully start before running commands
while ! netcat -z localhost 3306; do
  echo "MariaDB is still initializing..."
  sleep 3
done

echo "MariaDB is up and running!"

# Execute database updates
sh /updateDb.sh
