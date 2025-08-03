#!/bin/bash

# Start MariaDB in the background
mysqld_safe &
pid=$!

# Wait for MariaDB to be available
echo "Waiting for MariaDB to start..."
until mysql -u root -e "SELECT 1" > /dev/null 2>&1; do
  echo "MariaDB is not yet ready. Retrying in 2 seconds..."
  sleep 2
done
echo "MariaDB is ready."

# Now that MariaDB is ready, perform the initialization
echo "Creating database and user..."
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS \`$WORDPRESS_DB_NAME\`;"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$WORDPRESS_DB_USER'@'%' IDENTIFIED BY '$WORDPRESS_DB_PASSWORD';"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON \`$WORDPRESS_DB_NAME\`.* TO '$WORDPRESS_DB_USER'@'%';"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"
echo "Initialization complete."

# Stop the temporary MariaDB process
kill "$pid"
wait "$pid"

# Execute the final CMD to start the main service
exec "$@"