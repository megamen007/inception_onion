# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mboudrio <mboudrio@student.1337.ma>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/08 03:23:53 by mboudrio          #+#    #+#              #
#    Updated: 2024/11/08 03:23:56 by mboudrio         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


FROM debian:bullseye

RUN apt-get update && \\
    apt-get install -y nginx && \\
    mkdir -p /var/ww/html/wordpress

COPY ./tools/nginx.conf  /etc/nginx/conf.d

COPY nginx.sh  /usr/local/bin/nginx.sh
RUN chmod +x /usr/local/bin/nginx.sh

ENTRYPOINT ["/usr/local/bin/nginx.sh"]

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]