#!/bin/bash

FILE="$1"
BUCKET="$2"
EXPIRATION="$3"

if [ $# -ne 3 ]; then
    echo "Usage: $0 localfile bucketname expiration_seconds"
    exit 1
fi

if [ ! -f "$FILE" ]; then
    echo "Error: file '$FILE' does not exist."
    exit 1
fi

echo "Uploading $FILE to s3://$BUCKET/"
aws s3 cp "$FILE" "s3://$BUCKET/"

if [ $? -ne 0 ]; then
    echo "Upload failed."
    exit 1
fi

BASENAME=$(basename "$FILE")

echo "Generating presigned URL for s3://$BUCKET/$BASENAME"
aws s3 presign --expires-in "$EXPIRATION" "s3://$BUCKET/$BASENAME"

