from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, func
from typing import Optional

from app.models.item import Item
from app.schemas.item import ItemCreate, ItemUpdate


class ItemService:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_by_id(self, item_id: int) -> Optional[Item]:
        result = await self.db.execute(select(Item).where(Item.id == item_id))
        return result.scalar_one_or_none()

    async def get_all(self, skip: int = 0, limit: int = 10, owner_id: Optional[int] = None):
        query = select(Item)
        count_query = select(func.count(Item.id))

        if owner_id:
            query = query.where(Item.owner_id == owner_id)
            count_query = count_query.where(Item.owner_id == owner_id)

        count_result = await self.db.execute(count_query)
        total = count_result.scalar()

        result = await self.db.execute(
            query.offset(skip).limit(limit).order_by(Item.created_at.desc())
        )
        items = result.scalars().all()
        return total, items

    async def create(self, item_data: ItemCreate) -> Item:
        item = Item(
            title=item_data.title,
            description=item_data.description,
            owner_id=item_data.owner_id,
        )
        self.db.add(item)
        await self.db.flush()
        await self.db.refresh(item)
        return item

    async def update(self, item_id: int, item_data: ItemUpdate) -> Optional[Item]:
        item = await self.get_by_id(item_id)
        if not item:
            return None
        update_data = item_data.model_dump(exclude_unset=True)
        for field, value in update_data.items():
            setattr(item, field, value)
        await self.db.flush()
        await self.db.refresh(item)
        return item

    async def delete(self, item_id: int) -> bool:
        item = await self.get_by_id(item_id)
        if not item:
            return False
        await self.db.delete(item)
        await self.db.flush()
        return True
