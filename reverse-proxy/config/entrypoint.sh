#!/bin/bash
set -e

ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
echo "$TZ" > /etc/timezone && \
dpkg-reconfigure -f noninteractive tzdata > /dev/null 2>&1

unset VAR_ERROR
if [ -z "$AWS_KEY" ]; then echo 'ERROR: Required variable AWS_KEY is not set!'; export VAR_ERROR=1; fi
if [ -z "$AWS_SECRET" ]; then echo 'ERROR: Required variable AWS_SECRET is not set!'; export VAR_ERROR=1; fi
if [ -z "$AWS_REGION" ]; then echo 'ERROR: Required variable AWS_REGION is not set!'; export VAR_ERROR=1; fi
if [ -z "$DOMAIN" ]; then echo 'ERROR: Required variable DOMAIN is not set!'; export VAR_ERROR=1; fi
if [ -z "$EMAIL" ]; then echo 'ERROR: Required variable EMAIL is not set!'; export VAR_ERROR=1; fi
if [ -n "$VAR_ERROR" ]; then exit 1; fi

aws configure set aws_access_key_id $AWS_KEY
aws configure set aws_secret_access_key $AWS_SECRET
aws configure set default.region $AWS_REGION
aws configure set default.output $AWS_OUTPUT

BOOT_FILE="/opt/.first_boot_false"
if [ ! -e $BOOT_FILE ]; then
	mkdir -p /etc/nginx/htpasswd
	rm -rf /etc/nginx/sites-available/*
	rm -rf /etc/nginx/sites-enabled/*
	cp -rfun /opt/config/nginx/* /etc/nginx
	mkdir -p "$(dirname "$BOOT_FILE")"
	touch "$BOOT_FILE"
fi

cat <<EOF >/etc/cron.d/nginx-reload
0 0 * * * root if /usr/bin/pgrep -x "nginx" >/dev/null; then /etc/init.d/nginx reload; fi
EOF

certbot certonly \
	--dns-route53 \
	--non-interactive \
	--agree-tos -m $EMAIL \
	-d $DOMAIN \
	-d "*.$DOMAIN" \
	--server https://acme-v02.api.letsencrypt.org/directory

service cron start > /dev/null 2>&1

echo "Reverse Proxy is running!"

# KEEP SERVER RUNNING
exec $(which nginx) -c /etc/nginx/nginx.conf -g "daemon off;"
