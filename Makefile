ENV_FILE = --env-file ./docker/.env.docker

build:
	- chmod +x ./docker/build.sh
	- ./docker/build.sh
	- docker compose $(ENV_FILE) up -d
	- docker compose $(ENV_FILE) logs app -f

kill:
	- docker stop app queue nginx db myadmin
	- docker rm app queue nginx db myadmin
	- docker system prune -af --volumes
	- rm -r repository .docker

start:
	- docker start app queue nginx db myadmin

stop:
	- docker stop app queue nginx db myadmin

restart:
	- docker restart app queue nginx db myadmin

logs:
	- docker compose $(ENV_FILE) logs -f

shell:
	- docker compose $(ENV_FILE) exec app /bin/bash

queue-shell:
	- docker compose $(ENV_FILE) exec queue /bin/bash

test:
	- docker compose $(ENV_FILE) exec app php artisan test

clean:
	- docker system prune -af --volumes

down:
	- docker compose $(ENV_FILE) down

reset: 
	- docker compose $(ENV_FILE) down --volumes --remove-orphans
	- docker system prune -af --volumes

migrate:
	- docker compose $(ENV_FILE) exec app php artisan migrate

install:
	- docker compose $(ENV_FILE) exec app composer install
	- docker compose $(ENV_FILE) exec app php artisan key:generate

update:
	- docker compose $(ENV_FILE) exec app composer update

uninstall:
	- rm -r docker --force
	- rm docker-compose.yml --force
	- rm Dockerfile --force
	- rm Makefile --force

.PHONY: build kill start stop restart logs shell queue-shell test migrate install update clean down up reset uninstall
