from fastapi import FastAPI

from models.base import Base
from database import engine
from routes.auth import router


app = FastAPI()

app.include_router(router, prefix='/auth')

# Create tables after defining the model
Base.metadata.create_all(engine)
