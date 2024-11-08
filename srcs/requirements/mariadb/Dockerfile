# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mboudrio <mboudrio@student.1337.ma>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/08 03:23:18 by mboudrio          #+#    #+#              #
#    Updated: 2024/11/08 03:23:19 by mboudrio         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #



From debian:bullseye

RUN apt-get update && \
    apt-get install -y mariadb-server

COPY ./tools/mariadb.sh /

RUN chmod +x /mariadb.sh

EXPOSE 3306

ENTRYPOINT ["sh" , "mariadb.sh"]

CMD ["mariadb", "--user=root", "--bind-address=0.0.0.0"]

# The --bind-address option specifies which network interfaces the MariaDB server should listen to for incoming connections.
# Setting it to 0.0.0.0 allows MariaDB to accept connections from any IP address. Without this setting, it might be configured to only allow connections from localhost (127.0.0.1), limiting access to the database from outside the container.
