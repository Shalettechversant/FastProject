from fastapi import APIRouter, HTTPException
from sqlalchemy import select
from app.database import engine, SessionLocal
from app.models import users
from typing import List

router = APIRouter()

# Endpoint to insert a new user
@router.post("/users/", response_model=dict)
async def create_user(username: str):
    try:
        async with SessionLocal() as session:
            async with session.begin():
                new_user = users.insert().values(username=username)
                await session.execute(new_user)
                await session.commit()
    except Exception as e:
        # Log the exception for debugging purposes
        print("Error:", e)
        raise HTTPException(status_code=500, detail="Failed to create user")
    
    return {"message": "User created successfully"}

# Endpoint to fetch all users
@router.get("/users/", response_model=List[dict])
async def read_users():
    try:
        async with SessionLocal() as session:
            query = select([users])
            result = await session.execute(query)
            users_list = result.fetchall()
            # Convert SQLAlchemy Row objects to dictionaries
            return [dict(user) for user in users_list]
    except Exception as e:
        raise HTTPException(status_code=500, detail="Failed to fetch users")
