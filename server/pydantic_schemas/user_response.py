from pydantic import BaseModel


class UserResponse(BaseModel):
    id: str
    name: str
    email: str
    password: str

    class Config:
        orm_mode = True  # Tells Pydantic to treat the SQLAlchemy model as a dict
