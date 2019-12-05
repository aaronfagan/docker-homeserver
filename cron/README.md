# Cron
This image is an always-on solution to run cron jobs on an easily definable schedule. Mount points allow further customization beyond the standards outlined below.

- Cron job scripts can be written in standard `.sh` files.
- Any file whose name starts with an underscore (`_`) are ommitted from cron schedules.
- Comes pre-installed with the AWS CLI.

## Environment Variables
Variables without default are required.

**`AWS_KEY`**
- Your IAM user key.

**`AWS_SECRET`**
- Your IAM user secret.

**`AWS_REGION`**
- The AWS region your Route 53 hosted zone is in.

**`CRON`**
- **Options:** `minutely, hourly, daily, weekly, monthly, annually, reboot`
- Which cron jobs you want to enable.

# Contributors
* Aaron Fagan - [Github](https://github.com/aaronfagan), [Website](https://www.aaronfagan.ca/)
