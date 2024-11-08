# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mboudrio <mboudrio@student.1337.ma>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/08 03:24:44 by mboudrio          #+#    #+#              #
#    Updated: 2024/11/08 03:24:46 by mboudrio         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


FROM debian::bullseye

RUN apt-get update && apt install -y wget

RUN apt-get install -y php8.2-fpm php8.2-mysql php8.2-curl mariadb-client

RUN mkdir -p /var/ww/html

COPY ./tools/wordpress.sh .

RUN chmod +x script.sh

EXPOSE 9000

CMD ["sh", "wordpress.sh"]
