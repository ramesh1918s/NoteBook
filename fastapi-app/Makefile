.PHONY: help build up down logs shell test migrate

help:
	@echo ""
	@echo "  FastAPI + PostgreSQL — Available Commands"
	@echo "  ─────────────────────────────────────────"
	@echo "  make build     Build Docker images"
	@echo "  make up        Start all containers (detached)"
	@echo "  make down      Stop and remove containers"
	@echo "  make logs      Tail app logs"
	@echo "  make shell     Open shell inside app container"
	@echo "  make test      Run tests inside container"
	@echo "  make migrate   Run Alembic migrations"
	@echo "  make pgadmin   Start pgAdmin UI (port 5050)"
	@echo ""

build:
	docker compose build

up:
	docker compose up -d

down:
	docker compose down

logs:
	docker compose logs -f app

shell:
	docker compose exec app /bin/bash

test:
	docker compose exec app pytest tests/ -v

migrate:
	docker compose exec app alembic upgrade head

pgadmin:
	docker compose --profile tools up -d pgadmin
	@echo "pgAdmin running at http://localhost:5050"
