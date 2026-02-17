#!/usr/bin/env python3

import argparse
import logging
import os
import sys
import time
from datetime import timezone

import pandas as pd
import requests

API_URL = "http://api.open-notify.org/iss-now.json"


def init_logger() -> logging.Logger:
    logger = logging.getLogger("iss_etl")
    logger.setLevel(logging.INFO)

    if not logger.handlers:
        handler = logging.StreamHandler(sys.stdout)
        formatter = logging.Formatter(
            fmt="%(asctime)s | %(levelname)s | %(name)s | %(message)s",
            datefmt="%Y-%m-%d %H:%M:%S",
        )
        handler.setFormatter(formatter)
        logger.addHandler(handler)
    return logger


def extract(logger: logging.Logger) -> dict:
    logger.info("EXTRACT: Requesting ISS location from API: %s", API_URL)

    try:
        resp = requests.get(API_URL, timeout=10)
        resp.raise_for_status()  
        data = resp.json()
    except requests.exceptions.RequestException as e:
        logger.error("EXTRACT: Network/HTTP error while calling API: %s", e)
        raise RuntimeError("Failed to fetch ISS data from API") from e
    except ValueError as e:
        logger.error("EXTRACT: Response was not valid JSON: %s", e)
        raise RuntimeError("API did not return valid JSON") from e

    if not isinstance(data, dict) or data.get("message") != "success":
        logger.error("EXTRACT: Unexpected API response structure: %s", data)
        raise RuntimeError("Unexpected API response structure")

    logger.info("EXTRACT: Success. Timestamp=%s", data.get("timestamp"))
    return data
def transform(logger: logging.Logger, record: dict) -> pd.DataFrame:
    logger.info("TRANSFORM: Converting JSON to tabular format")

    ts = record.get("timestamp")
    pos = record.get("iss_position", {})
    latitude = pos.get("latitude")
    longitude = pos.get("longitude")
    dt_utc = pd.to_datetime(ts, unit="s", utc=True)
    dt_str = dt_utc.strftime("%Y-%m-%d %H:%M:%S")

    row = {
        "timestamp_unix": ts,
        "timestamp_utc": dt_str,
        "latitude": float(latitude) if latitude is not None else None,
        "longitude": float(longitude) if longitude is not None else None,
    }

    df = pd.DataFrame([row])
    logger.info("TRANSFORM: Created 1-row DataFrame (%d columns)", df.shape[1])
    return df
def load(logger: logging.Logger, df_row: pd.DataFrame, csv_file: str) -> None:
    logger.info("LOAD: Writing row to CSV: %s", csv_file)
    parent = os.path.dirname(csv_file)
    if parent:
        os.makedirs(parent, exist_ok=True)
    if os.path.exists(csv_file):
        df_row.to_csv(csv_file, mode="a", header=False, index=False)
        logger.info("LOAD: Appended 1 row to existing CSV")
    else: 
        df_row.to_csv(csv_file, mode="w", header=True, index=False)
        logger.info("LOAD: Created new CSV and wrote header + 1 row")


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Track ISS location and append results to a CSV file."
    )
    parser.add_argument(
        "csv_file",
        help="Output CSV file path (e.g., iss_locations.csv)",
    )
    args = parser.parse_args()

    logger = init_logger()
    logger.info("Starting ISS ETL pipeline")

    record = extract(logger)
    df_row = transform(logger, record)
    load(logger, df_row, args.csv_file)

    logger.info("Done.")


if __name__ == "__main__":
    main()