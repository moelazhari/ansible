#!/bin/bash

mkdir -p /run/php

# Check if wp-config.php exists. This prevents reinstalling on container restarts.
if [[ ! -f /var/www/html/wp-config.php ]]
then
    # Configure WordPress
    wp config create --path=/var/www/html --dbhost=${WORDPRESS_DB_HOST} --dbname=${WORDPRESS_DB_NAME} --dbuser=${WORDPRESS_DB_USER} \
    --dbpass=${WORDPRESS_DB_PASSWORD} --allow-root
    
    # Install WordPress
    wp core install --path=/var/www/html --url=${WORDPRESS_URL} --title="${WORDPRESS_TITLE}" --admin_user=${WORDPRESS_ADMIN} \
    --admin_password=${WORDPRESS_ADMIN_PASSWORD} --admin_email=${WORDPRESS_ADMIN_EMAIL} --allow-root
    
    # Create a new user
    wp user create --path=/var/www/html ${WORDPRESS_USER} ${WORDPRESS_USER_EMAIL} --user_pass=${WORDPRESS_USER_PASSWORD} --allow-root
fi

exec "$@"