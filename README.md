# AWS S3 Free Tier Usage Alert Script

A beginner-friendly Bash script to monitor your AWS S3 bucket usage and send email alerts when you're close to exceeding the 5 GB Free Tier limit.
This helps prevent surprise billing and encourages safe, cost-efficient cloud usage.

## 📌 Features

- Checks total size of an S3 bucket
- Compares it to a safe threshold (default: 4900 MB)
- Sends an email alert if the threshold is crossed
- Asks before syncing local files to the bucket
- Skips upload if you're over the safe limit


## Why This Matters

- Avoids unexpected AWS charges
- Helps students and beginners stay within Free Tier limits
- No need for AWS Budgets, CloudWatch, or complex setup
- Simple, manual control using only Bash, AWS CLI, and mailutils

##  Prerequisites

- AWS CLI installed and configured with `aws configure`
- An existing S3 bucket
- `mailutils` or `mailx` installed for email alerts

Install mailutils (Debian/Ubuntu):
sudo apt install mailutils

Install mailx (RHEL/CentOS):
sudo dnf install mailx


## Usage

1. Clone this repository or copy the script:
git clone https://github.com/your-username/aws-s3-alert-script.git
cd aws-s3-alert-script


2. Open the script and update:
- `BUCKET\\\_NAME` — your actual S3 bucket name
- `EMAIL` — your email address to receive alerts
- `./your-folder-path` — the local folder you want to sync

3. Make the script executable:
chmod +x check_s3_usage.sh


4. Run the script:
./check_s3_usage.sh

## Test Alert (Optional)
To simulate a high usage and test email alerts, temporarily add this line before the `if` block:
S3_USAGE_MB=5000

## Optional: Schedule with Cron
To check usage every day at 8 AM:
```bash
crontab -e
Add:
0 8 * * * /path/to/check_s3_usage.sh >> /path/to/logfile.log 2>&1

## Project Structure
aws-s3-alert-script/
├── check_s3_usage.sh
└── README.md

## Example Email Alert
Subject: AWS S3 Free Tier Usage Warning

ALERT: S3 bucket 'your-bucket-name' is using 4950 MB (limit: 4900 MB). Upload skipped to avoid AWS charges.
