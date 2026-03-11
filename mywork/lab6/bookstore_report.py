import os
from pymongo import MongoClient

MONGODB_ATLAS_URL = os.getenv("MONGODB_ATLAS_URL")
MONGODB_ATLAS_USER = os.getenv("MONGODB_ATLAS_USER")
MONGODB_ATLAS_PWD = os.getenv("MONGODB_ATLAS_PWD")


def main():
    if not MONGODB_ATLAS_URL or not MONGODB_ATLAS_USER or not MONGODB_ATLAS_PWD:
        raise ValueError(
            "Missing MongoDB Atlas environment variables. "
            "Check MONGODB_ATLAS_URL, MONGODB_ATLAS_USER, and MONGODB_ATLAS_PWD."
        )

    client = MongoClient(
        MONGODB_ATLAS_URL,
        username=MONGODB_ATLAS_USER,
        password=MONGODB_ATLAS_PWD
    )

    db = client["bookstore"]
    authors = db["authors"]

    total = authors.count_documents({})
    print("Total authors:", total)
    print()

    for author in authors.find({}, {"_id": 0, "name": 1, "nationality": 1}):
        print(f"{author.get('name', 'Unknown')} - {author.get('nationality', 'Unknown')}")

    client.close()


if __name__ == "__main__":
    main()
