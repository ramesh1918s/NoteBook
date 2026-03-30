# 🚀 FastAPI + PostgreSQL — Production-Ready REST API

A complete, containerized REST API built with **FastAPI**, **PostgreSQL**, **SQLAlchemy (async)**, and **Docker**.

---

## 📁 Project Structure

```
fastapi-app/
├── app/
│   ├── main.py                  # App entry, CORS, lifespan
│   ├── core/
│   │   └── config.py            # Pydantic settings (.env)
│   ├── db/
│   │   └── database.py          # Async engine + session
│   ├── models/
│   │   ├── user.py              # User ORM model
│   │   └── item.py              # Item ORM model
│   ├── schemas/
│   │   ├── user.py              # Pydantic request/response
│   │   └── item.py
│   ├── services/
│   │   ├── user_service.py      # User CRUD logic
│   │   └── item_service.py      # Item CRUD logic
│   └── api/routes/
│       ├── health.py            # GET /api/v1/health
│       ├── users.py             # /api/v1/users
│       └── items.py             # /api/v1/items
├── alembic/                     # DB migrations
│   ├── env.py
│   └── versions/
│       └── 0001_initial.py
├── tests/
│   ├── test_users.py
│   └── test_items.py
├── Dockerfile                   # Multi-stage build
├── docker-compose.yml           # App + DB + pgAdmin
├── alembic.ini
├── requirements.txt
├── Makefile
└── .env.example
```

---

## ⚡ Quick Start

### 1. Setup environment

```bash
cp .env.example .env
# Edit .env to set your passwords
```

### 2. Build & run with Docker

```bash
docker compose up --build -d
```

### 3. Access the app

| Service   | URL                              |
|-----------|----------------------------------|
| API Docs  | http://localhost:8000/docs       |
| ReDoc     | http://localhost:8000/redoc      |
| Health    | http://localhost:8000/api/v1/health |
| pgAdmin   | http://localhost:5050 (optional) |

---

## 📡 API Endpoints

### Users
| Method | Endpoint              | Description          |
|--------|-----------------------|----------------------|
| GET    | /api/v1/users/        | List users           |
| POST   | /api/v1/users/        | Create user          |
| GET    | /api/v1/users/{id}    | Get user by ID       |
| PATCH  | /api/v1/users/{id}    | Update user          |
| DELETE | /api/v1/users/{id}    | Delete user          |

### Items
| Method | Endpoint              | Description          |
|--------|-----------------------|----------------------|
| GET    | /api/v1/items/        | List items           |
| POST   | /api/v1/items/        | Create item          |
| GET    | /api/v1/items/{id}    | Get item by ID       |
| PATCH  | /api/v1/items/{id}    | Update item          |
| DELETE | /api/v1/items/{id}    | Delete item          |

---

## 🛠 Makefile Commands

```bash
make build      # Build Docker images
make up         # Start all containers
make down       # Stop containers
make logs       # Tail app logs
make shell      # Shell into app container
make test       # Run pytest
make migrate    # Run Alembic migrations
make pgadmin    # Start pgAdmin UI
```

---

## 🔧 Running Locally (without Docker)

```bash
python -m venv venv
source venv/bin/activate        # Windows: venv\Scripts\activate
pip install -r requirements.txt

# Set env vars (or use .env file)
export POSTGRES_HOST=localhost
export POSTGRES_USER=postgres
export POSTGRES_PASSWORD=postgres
export POSTGRES_DB=appdb

uvicorn app.main:app --reload --port 8000
```

---

## 🧪 Running Tests

```bash
pip install aiosqlite pytest-asyncio
pytest tests/ -v
```

---

## 📦 Example API Requests

### Create a user
```bash
curl -X POST http://localhost:8000/api/v1/users/ \
  -H "Content-Type: application/json" \
  -d '{"email":"john@example.com","username":"john","password":"secret123"}'
```

### Create an item
```bash
curl -X POST http://localhost:8000/api/v1/items/ \
  -H "Content-Type: application/json" \
  -d '{"title":"My Item","description":"Hello","owner_id":1}'
```

### List all items
```bash
curl http://localhost:8000/api/v1/items/?skip=0&limit=10
```

---

## 🏗 Tech Stack

| Layer       | Technology               |
|-------------|--------------------------|
| Framework   | FastAPI 0.115            |
| ORM         | SQLAlchemy 2.0 (async)   |
| Database    | PostgreSQL 16            |
| Migrations  | Alembic                  |
| Validation  | Pydantic v2              |
| Server      | Uvicorn                  |
| Container   | Docker + Docker Compose  |
| Tests       | Pytest + httpx           |
