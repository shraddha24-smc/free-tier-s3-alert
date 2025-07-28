#!/bin/bash

# AWS S3 Usage Alert Script

BUCKET_NAME="your-bucket-name"
LIMIT_MB=4900
EMAIL="your.email@example.com"

S3_USAGE_BYTES=$(aws s3 ls s3://$BUCKET_NAME --recursive --summarize | grep "Total Size" | awk '{print $3}')
S3_USAGE_MB=$((S3_USAGE_BYTES / 1024 / 1024))

if [ "$S3_USAGE_MB" -ge "$LIMIT_MB" ]; then
    ALERT_MSG="ALERT: S3 bucket '$BUCKET_NAME' is using $S3_USAGE_MB MB (limit: $LIMIT_MB MB). Upload skipped to avoid AWS charges."

    echo "$ALERT_MSG" | mail -s "AWS S3 Free Tier Usage Warning" "$EMAIL"
    echo "$ALERT_MSG"
    exit 1
fi

read -p "Do you want to upload your files to S3? (yes/no): " answer

if [ "$answer" == "yes" ]; then
    aws s3 sync ./your-folder-path s3://$BUCKET_NAME
    echo "Files uploaded to S3."
else
    echo "Upload cancelled."
fi

