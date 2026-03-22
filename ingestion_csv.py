import os
import pandas as pd

from pathlib import Path
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")

raw_data = Path(__file__).parent / 'raw_readings.csv'
conn_string = f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"

try:
    df = pd.read_csv(raw_data, delimiter = ",")

    df.to_sql(
        name = "bronze_air_quality",
        con = conn_string,
        if_exists = "replace"
    )

    print("Ingestion Completed!")

except Exception as e:
    print("Ingestion Failed!")
    print(f"Error details: {e}")

