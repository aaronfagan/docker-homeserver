#!/bin/bash
set -e

ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
echo "${TZ}" > /etc/timezone && \
dpkg-reconfigure -f noninteractive tzdata > /dev/null 2>&1

VARS_REQUIRED=(
    AWS_KEY
    AWS_SECRET
    AWS_REGION
    DOMAIN
    EMAIL
)

for VAR in "${VARS_REQUIRED[@]}"; do
    if [ -z "${!VAR}" ]; then
    	echo "ERROR: Required variable \"${VAR}\" is not set!";
    	VAR_ERROR=true;
    fi
done
if [ "${VAR_ERROR}" ]; then exit 1; fi

aws configure set aws_access_key_id ${AWS_KEY}
aws configure set aws_secret_access_key ${AWS_SECRET}
aws configure set default.region ${AWS_REGION}
aws configure set default.output json

cat <<EOF >/etc/cron.d/nginx-reload
0 6 * * * root if /usr/bin/pgrep -x "nginx" > /dev/null 2>&1; then /etc/init.d/nginx reload; fi
EOF

certbot certonly \
	--dns-route53 \
	--non-interactive \
	--agree-tos -m ${EMAIL} \
	-d ${DOMAIN} \
	-d "*.${DOMAIN}" \
	--server https://acme-v02.api.letsencrypt.org/directory

service cron start > /dev/null 2>&1
echo "Reverse Proxy is running!"
exec $(which nginx) -c /etc/nginx/nginx.conf -g "daemon off;"