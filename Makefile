DEV_COMPOSE_FILE=docker-compose.dev.yml

up\:dev:
	docker compose -f $(DEV_COMPOSE_FILE) up

down\:dev:
	docker compose -f $(DEV_COMPOSE_FILE) down

build\:dev:
	docker compose -f $(DEV_COMPOSE_FILE) build

PROD_COMPOSE_FILE=docker-compose.prod.yml

up\:prod:
	docker compose -f $(PROD_COMPOSE_FILE) up

down\:prod:
	docker compose -f $(PROD_COMPOSE_FILE) down

build\:prod:
	docker compose -f $(PROD_COMPOSE_FILE) build
