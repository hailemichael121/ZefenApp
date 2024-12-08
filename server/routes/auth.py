import uuid
import bcrypt
from fastapi import Depends, HTTPException, APIRouter

from database import get_db
from pydantic_schemas.login_user import LoginUser
from pydantic_schemas.user_create import UserCreate
from pydantic_schemas.user_response import UserResponse
from models.user import User
from sqlalchemy.orm import Session
import jwt

router = APIRouter()


@router.post('/signup', status_code=201,  response_model=UserResponse)
def signup_user(user: UserCreate, db: Session = Depends(get_db), ):
    # Check if user already exists
    user_db = db.query(User).filter(User.email == user.email).first()
    if user_db:
        raise HTTPException(status_code=400, detail='User already exists!')

    # Hash the password
    hashed_passwd = bcrypt.hashpw(user.password.encode(), bcrypt.gensalt())

    # Create the user and add to the database
    new_user = User(id=str(uuid.uuid4()), name=user.name,
                    email=user.email, password=hashed_passwd)

    db.add(new_user)
    db.commit()
    db.refresh(new_user)  # Refresh the instance to get the latest data

    return new_user  # FastAPI will serialize this to match the UserResponse model


@router.post('/login')
def login_user(user: LoginUser, db: Session = Depends(get_db)):
    user_db = db.query(User).filter(User.email == user.email).first()
    if not user_db:
        raise HTTPException(400, 'Email Not Found!')
    Check_Passwd = bcrypt.checkpw(user.password.encode(), user_db.password)
    if not Check_Passwd:
        raise HTTPException(400, 'Incorrect Password')

    token = jwt.encode({'id': user_db.id}, 'passord_key')
    return {'token': token, 'user': user_db}
