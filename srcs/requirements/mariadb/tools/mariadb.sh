# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    mariadb.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mboudrio <mboudrio@student.1337.ma>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/08 03:23:10 by mboudrio          #+#    #+#              #
#    Updated: 2024/11/08 03:23:11 by mboudrio         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


#!bin/sh

# if [ ! -d "/run/mysqld" ]: This checks if the directory /run/mysqld does not exist.
# mkdir /run/mysqld;: If /run/mysqld is missing, it creates this directory. This directory is often used by MariaDB to store runtime files like process IDs or lock files. Ensuring its existence helps avoid issues when MariaDB starts.

if [ ! -d "/run/mysqld" ]; then
    mkdir /run/mysqld;
fi

cat << EOF > /sql.sql
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';
EOF

# GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';: Grants all permissions on the database (DB_NAME) to the new user, enabling full access.

# ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';
# sets a password for the root user account, which is an administrative user with full control over all databases in MariaDB. By setting this password, you ensure that:
# Only users who know the root password can log in as root: Without this password, other users can’t access or modify the databases using the root account.
# Secure Access Control: Since the root account has powerful privileges, setting a strong password ensures it’s not easily accessed, especially if someone tries to access the database from the local machine (since root is allowed to connect only from localhost in this line).

mariadb --user=root --bootstrap < /sql.sql
# Runs MariaDB in bootstrap mode (single-user mode) to execute the SQL commands in /sql.sql. Bootstrap mode is used for initializing the database, allowing commands to run without a full MariaDB instance.
# --user=root : specifies the user to run this command.
# < /sql.sql : redirects the commands from /sql.sql as input for MariaDB, so MariaDB processes and applies these SQL commands.

exec "$@"

# "$@" represents all the arguments passed to the script. If, for example, you run the script like this:
# sh
# Copier le code
# ./your_script.sh mariadbd --user=root
# Then "$@" would expand to mariadbd --user=root.

# exec is a shell built-in command that replaces the current shell (or script process) with the command specified.
# Normally, when you run a command in a script, the script would run that command, wait for it to finish, and then exit. But by using exec, you’re telling the shell to replace itself with the command you want to run, without creating a new process.
# Why Replace the Shell Process?

# In a Docker container, especially, you want the main process (like mariadbd) to run as PID 1 (the first and main process) so that it can receive and respond to system signals (e.g., SIGTERM when stopping the container).
# By using exec, the script hands over control to the main command, and the command you run becomes the main process in the container instead of the shell script.

