#!/usr/bin/env python3

import sys
import os
import boto3
from botocore.exceptions import ClientError


def upload_private(s3, bucket, filename):
    key = os.path.basename(filename)
    with open(filename, "rb") as f:
        s3.put_object(Bucket=bucket, Key=key, Body=f)
    print(f"Private upload successful: s3://{bucket}/{key}")
    return key


def upload_public(s3, bucket, filename):
    key = os.path.basename(filename)
    with open(filename, "rb") as f:
        s3.put_object(Bucket=bucket, Key=key, Body=f, ACL="public-read")
    print(f"Public upload successful: s3://{bucket}/{key}")
    print(f"Public URL: https://s3.amazonaws.com/{bucket}/{key}")
    return key


def presign_object(s3, bucket, key, expiration=604800):
    url = s3.generate_presigned_url(
        "get_object",
        Params={"Bucket": bucket, "Key": key},
        ExpiresIn=expiration
    )
    print("Presigned URL:")
    print(url)


def main():
    if len(sys.argv) < 3:
        print("Usage: python3 s3_boto3_demo.py BUCKET PRIVATE_FILE [PUBLIC_FILE]")
        sys.exit(1)

    bucket = sys.argv[1]
    private_file = sys.argv[2]
    public_file = sys.argv[3] if len(sys.argv) > 3 else None

    s3 = boto3.client("s3", region_name="us-east-1")

    try:
        private_key = upload_private(s3, bucket, private_file)
        presign_object(s3, bucket, private_key)

        if public_file:
            upload_public(s3, bucket, public_file)

    except ClientError as e:
        print(f"AWS error: {e}")
        sys.exit(1)
    except FileNotFoundError as e:
        print(f"File error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
