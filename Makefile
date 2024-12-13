.PHONY: $(MAKECMDGOALS)

.DEFAULT_GOAL := help
SHELL := /bin/bash

### Docker commands ###

build: ## Build containers
	cd ./docker && docker compose build

rebuild: ## ReBuild containers
	cd ./docker && docker compose build --no-cache

up: ## Up containers
	cd ./docker && docker compose up -d

up-rebuild: ## Up containers
	cd ./docker && docker compose up -d --force-recreate --build

up-alone: ## Up containers from current project and remove others
	cd ./docker && docker compose up -d --remove-orphans

down: ## Down containers in current project
	cd ./docker && docker compose down

restart: ## Restart containers
	cd ./docker && docker compose restart

down-all: ## Down containers in current project and others
	cd ./docker && docker compose down --remove-orphans

down-v: ## Down containers in current project with data in volumes
	cd ./docker && docker compose down -v

connect-to-php-fpm: ## Run phpcs for ./src
	cd ./docker && docker compose exec -i -t --privileged hey-project-php-fpm bash

### Symfony commands ###

drop-database: ## Drop database
	cd ./docker && docker compose exec -i -t --privileged hey-project-php-fpm bin/console doctrine:schema:drop --force --full-database

migrations: ## Execute all migrations
	cd ./docker && docker compose exec -i -t --privileged hey-project-php-fpm bin/console doctrine:migrations:migrate -n

migration-diff: ## Create migration contains difference between db and current entities structure
	cd ./docker && docker compose exec -i -t --privileged hey-project-php-fpm bin/console doctrine:migrations:diff

cache-clear: ## Recreate cache
	rm -rf ./var/cache && cd ./docker && docker compose exec -i -t --privileged hey-project-php-fpm bin/console cache:clear --no-warmup

cache-warmup: ## Recreate cache
	rm -rf ./var/cache && cd ./docker && docker compose exec -i -t --privileged hey-project-php-fpm bin/console cache:warmup

clear-logs: ## Clear all logs
	truncate -s 0 ./var/log/*

test:
	cd ./docker && docker compose exec -i -t --privileged hey-project-php-fpm vendor/bin/codecept run tests -f

### HELP commands ###

help: ## Show current help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' ./Makefile | sort | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'
