from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine
from sqlalchemy.orm import sessionmaker

# Define your database URL
DATABASE_URL = "postgresql+asyncpg://postgres:admin@localhost:5435/fastdatabase"


# Create an asynchronous engine
engine = create_async_engine(DATABASE_URL, echo=True)

# Create a sessionmaker that will produce AsyncSession objects
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine, class_=AsyncSession)
