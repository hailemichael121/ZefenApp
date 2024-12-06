from sqlalchemy.orm import sessionmaker

from sqlalchemy import create_engine


DATABASE_URL = "postgresql://postgres:123456789@localhost:5432/Zefenic"

engine = create_engine(DATABASE_URL)
sessionLocal = sessionmaker(autoflush=False, autocommit=False, bind=engine)


def get_db():
    db = sessionLocal()
    try:
        yield db
    finally:
        db.close()
