
import uuid
from sqlalchemy import TEXT, VARCHAR, Column, LargeBinary
from models.base import Base


class User(Base):
    __tablename__ = 'users'

    id = Column(TEXT, primary_key=True, default=str(
        uuid.uuid4()))  # Fix: primary_key=True, UUID
    name = Column(VARCHAR(100), nullable=False)
    email = Column(VARCHAR(100), unique=True, nullable=False)
    # Fix: LargeBinary() instead of LargeBinary
    password = Column(LargeBinary(), nullable=False)
