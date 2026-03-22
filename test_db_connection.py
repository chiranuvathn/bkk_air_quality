import os

from dotenv import load_dotenv
from sqlalchemy import create_engine, text

# Load environment variables from .env file
load_dotenv()

DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")

conn_string = f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"

try:
    engine = create_engine(conn_string)

    with engine.connect() as connection:
        result = connection.execute(text("SELECT 1"))
        print("Connection Successful!")
        print(f"Database returned: {result.fetchone()}")

except Exception as e:
    print("Connection Failed!")
    print(f"Error details: {e}")

