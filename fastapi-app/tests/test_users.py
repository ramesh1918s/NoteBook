import pytest
from httpx import AsyncClient, ASGITransport
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine, async_sessionmaker

from app.main import app
from app.db.database import get_db, Base

# Use SQLite in-memory for tests
TEST_DATABASE_URL = "sqlite+aiosqlite:///:memory:"

engine_test = create_async_engine(TEST_DATABASE_URL, echo=False)
TestSessionLocal = async_sessionmaker(engine_test, class_=AsyncSession, expire_on_commit=False)


async def override_get_db():
    async with TestSessionLocal() as session:
        try:
            yield session
            await session.commit()
        except Exception:
            await session.rollback()
            raise


app.dependency_overrides[get_db] = override_get_db


@pytest.fixture(autouse=True)
async def setup_db():
    async with engine_test.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    yield
    async with engine_test.begin() as conn:
        await conn.run_sync(Base.metadata.drop_all)


@pytest.fixture
async def client():
    async with AsyncClient(transport=ASGITransport(app=app), base_url="http://test") as c:
        yield c


@pytest.mark.asyncio
async def test_create_user(client):
    response = await client.post("/api/v1/users/", json={
        "email": "test@example.com",
        "username": "testuser",
        "full_name": "Test User",
        "password": "password123",
    })
    assert response.status_code == 201
    data = response.json()
    assert data["email"] == "test@example.com"
    assert data["username"] == "testuser"
    assert "id" in data


@pytest.mark.asyncio
async def test_create_user_duplicate_email(client):
    payload = {"email": "dup@example.com", "username": "user1", "password": "password123"}
    await client.post("/api/v1/users/", json=payload)
    payload2 = {"email": "dup@example.com", "username": "user2", "password": "password123"}
    response = await client.post("/api/v1/users/", json=payload2)
    assert response.status_code == 400


@pytest.mark.asyncio
async def test_list_users(client):
    await client.post("/api/v1/users/", json={
        "email": "a@example.com", "username": "userA", "password": "password123"
    })
    response = await client.get("/api/v1/users/")
    assert response.status_code == 200
    data = response.json()
    assert data["total"] >= 1


@pytest.mark.asyncio
async def test_get_user(client):
    create = await client.post("/api/v1/users/", json={
        "email": "b@example.com", "username": "userB", "password": "password123"
    })
    user_id = create.json()["id"]
    response = await client.get(f"/api/v1/users/{user_id}")
    assert response.status_code == 200
    assert response.json()["id"] == user_id


@pytest.mark.asyncio
async def test_get_user_not_found(client):
    response = await client.get("/api/v1/users/99999")
    assert response.status_code == 404


@pytest.mark.asyncio
async def test_update_user(client):
    create = await client.post("/api/v1/users/", json={
        "email": "c@example.com", "username": "userC", "password": "password123"
    })
    user_id = create.json()["id"]
    response = await client.patch(f"/api/v1/users/{user_id}", json={"full_name": "Updated Name"})
    assert response.status_code == 200
    assert response.json()["full_name"] == "Updated Name"


@pytest.mark.asyncio
async def test_delete_user(client):
    create = await client.post("/api/v1/users/", json={
        "email": "d@example.com", "username": "userD", "password": "password123"
    })
    user_id = create.json()["id"]
    response = await client.delete(f"/api/v1/users/{user_id}")
    assert response.status_code == 204
    response = await client.get(f"/api/v1/users/{user_id}")
    assert response.status_code == 404
