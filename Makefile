# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mboudrio <mboudrio@student.1337.ma>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/08 03:26:53 by mboudrio          #+#    #+#              #
#    Updated: 2024/11/08 03:26:54 by mboudrio         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


all:

	@mkdir -p /home/mohamed/data/mariadb
	@mkdir -p /home/mohamed/data/wordpress
	@docker compose -f ./srcs/docker-compose.yml up -d --build

clean:

	@docker compose -f ./srcs/docker-compose.yml down

fclean:
	@rm -rf /home/mohamed/data/mariadb
	@rm -rf /home/mohamed/data/wordpress
	@docker system prune -af

re: fclean all

.PHONY:  clean all