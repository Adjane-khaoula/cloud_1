COMPOSE_FILE = srcs/docker-compose.yml
up:
	@docker-compose -f $(COMPOSE_FILE) up --build -d

down:
	@docker-compose -f $(COMPOSE_FILE) down || true

clean-volumes:
	@docker-compose -f $(COMPOSE_FILE) down -v || true

clean-images:
	@docker images -aq | xargs -r docker rmi -f 2>/dev/null || true
clean-hostv:
	@sudo rm -rf /home/ubuntu/data/mariadb/* 2>/dev/null || true
	@sudo rm -rf /home/ubuntu/data/wordpress/* 2>/dev/null || true

clean: clean-volumes clean-images

fclean: clean clean-hostv
	@docker system prune -f || true

re: fclean up
