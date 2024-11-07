#!/bin/bash

# -p The -p option in the mkdir command stands for "parents" it has two major things to do 
# Create any necessary parent directories in the specified path. For example, if you run mkdir -p /a/b/c, it will create /a, /a/b, and /a/b/c as needed
# Avoid errors if the directory already exists. Normally, mkdir would return an error if you try to create a directory that’s already there, but with -p, it will simply ignore this situation.
# /run/php is where runtime files for PHP will be stored.
mkdir -p /run/php

# Downloads WP-CLI, a command-line tool for managing WordPress.
# wget fetches this file from the specified URL (wp-cli.phar is the PHP archive for WP-CLI).
# wget is a command-line utility used to download files from the internet. It is commonly used on Unix-like systems (Linux, macOS) and is especially useful in scripts or when you need to download files without a web browser.
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar


chmod +x wp-cli.phar

# Moves wp-cli.phar to /usr/local/bin and renames it to wp.
# This makes WP-CLI accessible from any location in the system by simply running wp.
mv wp-cli.phar /usr/local/bin/wp

# sed -i edits files in place.
# This command changes PHP-FPM's listen directive to use port 9000 instead of a socket.
# /run/php/php8.2-fpm.sock was initially used for local communication. Changing it to 0.0.0.0:9000 enables PHP-FPM to listen on all network interfaces at port 9000, allowing remote connections.
# /etc/php/8.2/fpm/pool.d/www.conf is the PHP-FPM configuration file for the default pool.
sed -i "s|listen = /run/php/php8.2-fpm.sock|listen = 0.0.0.0:9000|g" /etc/php/8.2/fpm/pool.d/www.conf


mkdir -p /var/www/html/wordpress

# This makes it the working directory for subsequent WordPress setup commands.
cd /var/www/html/wordpress

# WP_CLI COMMANDS :

# Downloads the latest version of WordPress core files to the current directory.
# --allow-root allows WP-CLI to run as the root user (default in many Docker setups)
wp core download --allow-root


# Creates the wp-config.php file for WordPress, which defines database connection settings.
# --dbhost=mariadb:3306 defines the host (mariadb) and port (3306) where the database service is available.
wp config create --allow-root --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASSWORD} --dbhost=mariadb:3306

# Runs the WordPress installation with the following parameters:
# --url sets the site URL.
# --title sets the website title (e.g., “inception”).
# --admin_user, --admin_password, --admin_email create the WordPress admin account.
# The environment variables (${WEBSITE}, ${ADMIN}, etc.) are again used here to personalize the setup.
wp core install --allow-root --url=${WEBSITE} --title=inception --admin_user=${ADMIN} --admin_password=${PASS} --admin_email=${EMAIL}

# Creates a new WordPress user with the editor role.
# ${USER} and ${USER_MAIL} set the username and email.
# --role=editor assigns the editor role to the user.
# --user_pass=${USER_PASS} sets the password for the new user.
# This command is useful if additional users are needed, especially with specific roles other than admin.
wp user create --allow-root ${USER} ${USER_MAIL} --role=editor --user_pass=${USER_PASS}

# php-fpm8.2 starts PHP-FPM version 8.2.
# -F tells PHP-FPM to run in the foreground, which is a common setup in Docker containers.
# exec replaces the current shell process with php-fpm, making it the primary process (PID 1) in the container. This allows Docker to handle PHP-FPM directly for proper shutdown and restart behaviors.
exec php-fpm8.2 -F