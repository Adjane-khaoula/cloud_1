SRC = ./docker-compose.yml

HOME_DIR = $(HOME)

all:
	mkdir -p $(HOME_DIR)/cloud-1-volume
	mkdir -p $(HOME_DIR)/cloud-1-volume/wp $(HOME_DIR)/cloud-1-volume/db
	docker compose -f $(SRC) up -d

stop:
	docker compose -f $(SRC) stop

clean:
	docker compose -f $(SRC) down

lclean:
	docker compose -f $(SRC) down --rmi all

fclean: clean
	sudo rm -rf $(HOME_DIR)/cloud-1-volume
	docker volume rm app_cloud-1-db-vol app_cloud-1-wp-vol
#	docker system prune -a -f

re: fclean all

