#!usr/bin/env python3

import os
import sys
import glob
import logging
import boto3
from botocore.exceptions import BotoCoreError, ClientError


logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(message)s"
)
logger = logging.getLogger(__name__)


def parse_args():
  
    if len(sys.argv) != 3:
        logger.error("Usage: python3 upload_results.py INPUT_FOLDER BUCKET/PREFIX")
        sys.exit(1)

    input_folder = sys.argv[1]
    destination = sys.argv[2]
    return input_folder, destination


def upload(input_folder, destination):
   
    try:
        if not os.path.isdir(input_folder):
            raise FileNotFoundError(f"Input folder does not exist: {input_folder}")

        if "/" not in destination:
            raise ValueError("Destination must look like bucket/prefix/")

        bucket, prefix = destination.split("/", 1)
        if prefix and not prefix.endswith("/"):
            prefix += "/"

        files = sorted(glob.glob(os.path.join(input_folder, "results-*.csv")))

        if not files:
            logger.warning("No results-*.csv files found in %s", input_folder)
            return False

        s3 = boto3.client("s3", region_name="us-east-1")

        for filepath in files:
            filename = os.path.basename(filepath)
            key = f"{prefix}{filename}"
            logger.info("Uploading %s to s3://%s/%s", filepath, bucket, key)
            s3.upload_file(filepath, bucket, key)

        return True

    except (BotoCoreError, ClientError, FileNotFoundError, ValueError) as e:
        logger.error("Upload failed: %s", e)
        return False


def main():
    input_folder, destination = parse_args()
    success = upload(input_folder, destination)

    if success:
        logger.info("All matching files uploaded successfully.")
    else:
        logger.error("Script completed with errors or no files uploaded.")


if __name__ == "__main__":
    main()
