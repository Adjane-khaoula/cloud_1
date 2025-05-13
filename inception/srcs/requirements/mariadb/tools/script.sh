# #!/bin/bash
# service mariadb start
# sleep 10
# mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
# mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%'\
#          IDENTIFIED BY '${SQL_PASSWORD}';"
# mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%'\
#          IDENTIFIED BY '${SQL_PASSWORD}';"
# mysql -e "CREATE USER IF NOT EXISTS \`root\`@'%' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
# mysql   -e "FLUSH PRIVILEGES;"
# mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown
# exec  mysqld_safe --bind_address=0.0.0.0
#!/bin/bash

# Ensure directories exist and are owned properly
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Initialize DB if not already done
if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "Initializing MariaDB data directory..."
  mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
fi

# Start MariaDB in the background
mysqld_safe --datadir=/var/lib/mysql &
sleep 10

# Create DB and users
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"
mysql -e "CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

# Shut down the server
mysqladmin -uroot -p${SQL_ROOT_PASSWORD} shutdown

# Now start it in the foreground for Docker
exec mysqld_safe --datadir=/var/lib/mysql --bind-address=0.0.0.0










