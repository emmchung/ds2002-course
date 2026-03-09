import os
import requests
import mysql.connector
from datetime import datetime

API_URL = "http://api.open-notify.org/iss-now.json"


def get_db_connection():
    return mysql.connector.connect(
        host=os.getenv("DBHOST"),
        user=os.getenv("DBUSER"),
        password=os.getenv("DBPASS"),
        database="iss"
    )


def register_reporter(table, reporter_id, reporter_name):

    db = get_db_connection()
    cursor = db.cursor()

    check_query = f"SELECT reporter_id FROM {table} WHERE reporter_id = %s"
    cursor.execute(check_query, (reporter_id,))
    result = cursor.fetchone()

    if result is None:

        insert_query = f"""
        INSERT INTO {table} (reporter_id, reporter_name)
        VALUES (%s,%s)
        """

        cursor.execute(insert_query, (reporter_id, reporter_name))
        db.commit()
        print("Reporter registered")

    else:
        print("Reporter already exists")

    cursor.close()
    db.close()


def extract():

    response = requests.get(API_URL)
    return response.json()


def transform(data, reporter_id):

    message = data["message"]
    latitude = float(data["iss_position"]["latitude"])
    longitude = float(data["iss_position"]["longitude"])
    timestamp = datetime.utcfromtimestamp(data["timestamp"]).strftime('%Y-%m-%d %H:%M:%S')

    return (message, latitude, longitude, timestamp, reporter_id)


def load(table, row):

    db = get_db_connection()
    cursor = db.cursor()

    insert_query = f"""
    INSERT INTO {table}
    (message, latitude, longitude, timestamp, reporter_id)
    VALUES (%s,%s,%s,%s,%s)
    """

    cursor.execute(insert_query, row)
    db.commit()

    print("Location inserted")

    cursor.close()
    db.close()


def main():

    reporter_id = "mkt3qv"
    reporter_name = "Emma"

    register_reporter("reporters", reporter_id, reporter_name)

    data = extract()

    row = transform(data, reporter_id)

    load("locations", row)


if __name__ == "__main__":
    main()