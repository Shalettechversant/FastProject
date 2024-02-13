from fastapi import FastAPI, HTTPException

from app.routers import users
from app.errors import http_error_handler
from app.models import metadata 

app = FastAPI()

# metadata.create_all(database)

app.include_router(users.router)

app.add_exception_handler(HTTPException, http_error_handler)
