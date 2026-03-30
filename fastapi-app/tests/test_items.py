import pytest
from httpx import AsyncClient, ASGITransport

from tests.test_users import app, client, setup_db  # reuse fixtures


@pytest.mark.asyncio
async def test_create_item(client):
    # Create a user first
    user_resp = await client.post("/api/v1/users/", json={
        "email": "owner@example.com", "username": "owner1", "password": "password123"
    })
    owner_id = user_resp.json()["id"]

    response = await client.post("/api/v1/items/", json={
        "title": "Test Item",
        "description": "A test item",
        "owner_id": owner_id,
    })
    assert response.status_code == 201
    data = response.json()
    assert data["title"] == "Test Item"
    assert data["owner_id"] == owner_id


@pytest.mark.asyncio
async def test_list_items(client):
    user_resp = await client.post("/api/v1/users/", json={
        "email": "owner2@example.com", "username": "owner2", "password": "password123"
    })
    owner_id = user_resp.json()["id"]
    await client.post("/api/v1/items/", json={"title": "Item 1", "owner_id": owner_id})
    await client.post("/api/v1/items/", json={"title": "Item 2", "owner_id": owner_id})

    response = await client.get("/api/v1/items/")
    assert response.status_code == 200
    assert response.json()["total"] >= 2


@pytest.mark.asyncio
async def test_get_item(client):
    user_resp = await client.post("/api/v1/users/", json={
        "email": "owner3@example.com", "username": "owner3", "password": "password123"
    })
    owner_id = user_resp.json()["id"]
    item_resp = await client.post("/api/v1/items/", json={"title": "My Item", "owner_id": owner_id})
    item_id = item_resp.json()["id"]

    response = await client.get(f"/api/v1/items/{item_id}")
    assert response.status_code == 200
    assert response.json()["id"] == item_id


@pytest.mark.asyncio
async def test_update_item(client):
    user_resp = await client.post("/api/v1/users/", json={
        "email": "owner4@example.com", "username": "owner4", "password": "password123"
    })
    owner_id = user_resp.json()["id"]
    item_resp = await client.post("/api/v1/items/", json={"title": "Old Title", "owner_id": owner_id})
    item_id = item_resp.json()["id"]

    response = await client.patch(f"/api/v1/items/{item_id}", json={"title": "New Title"})
    assert response.status_code == 200
    assert response.json()["title"] == "New Title"


@pytest.mark.asyncio
async def test_delete_item(client):
    user_resp = await client.post("/api/v1/users/", json={
        "email": "owner5@example.com", "username": "owner5", "password": "password123"
    })
    owner_id = user_resp.json()["id"]
    item_resp = await client.post("/api/v1/items/", json={"title": "Delete Me", "owner_id": owner_id})
    item_id = item_resp.json()["id"]

    response = await client.delete(f"/api/v1/items/{item_id}")
    assert response.status_code == 204
    assert (await client.get(f"/api/v1/items/{item_id}")).status_code == 404
