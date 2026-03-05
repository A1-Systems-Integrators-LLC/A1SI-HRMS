.PHONY: help setup build dev test lint static security clean migrate install

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Install all dependencies
	cd backend && pip install -r requirements.txt
	cd frontend && npm install

setup: install ## Full setup: install deps, migrate DB, create superuser
	cd backend && python manage.py migrate
	cd backend && python manage.py createsuperuser --noinput || true
	@echo "Setup complete."

build: ## Production build (frontend + backend static)
	cd frontend && npm run build
	cd backend && python manage.py collectstatic --noinput

dev: ## Run backend + frontend in dev mode
	@echo "Starting backend on :8000 and frontend on :5173..."
	cd backend && daphne -b 0.0.0.0 -p 8000 config.asgi:application &
	cd frontend && npm run dev

test: ## Run all tests (pytest + vitest)
	cd backend && pytest
	cd frontend && npx vitest run

lint: ## Run linters (ruff + eslint)
	cd backend && ruff check .
	cd frontend && npx eslint src/

static: ## Run type checking (mypy)
	cd backend && mypy .

security: ## Run security audits (pip-audit + npm audit)
	cd backend && pip-audit
	cd frontend && npm audit

clean: ## Remove build artifacts and caches
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name .pytest_cache -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name .mypy_cache -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name .ruff_cache -exec rm -rf {} + 2>/dev/null || true
	rm -rf frontend/dist
	rm -rf backend/staticfiles

migrate: ## Run Django migrations
	cd backend && python manage.py makemigrations
	cd backend && python manage.py migrate
