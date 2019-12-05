#!/bin/bash
set -e

ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
echo "${TZ}" > /etc/timezone && \
dpkg-reconfigure -f noninteractive tzdata > /dev/null 2>&1

VARS_REQUIRED=(
    AWS_KEY
    AWS_SECRET
    AWS_REGION
    CRONS
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

CRON_ACCEPT=(
	minutely
	hourly
	daily
	weekly
	monthly
	annually
	reboot
)

for CRON in $(echo ${CRONS} | sed -e "s/,/ /g" -e "s/  / /g"); do
	CRON=$(echo ${CRON#*_} | tr A-Z a-z)
    if [[ ! " ${CRON_ACCEPT[@]} " =~ " ${CRON} " ]]; then
    	echo "Cron \"${CRON}\" is not acceptable. Skipping...";
    else
		DIR="/root/scripts/${CRON}"
		mkdir -p ${DIR}
		if [ "${CRON}" == "minutely" ]; then
			TIME="* * * * *";
		else
			TIME="@${CRON}";
		fi
		echo "${TIME} root /usr/bin/find ${DIR} -path ${DIR}/_* -prune -o -type f ! -iname "_*.sh" -iname "*.sh" -exec chmod +x {} \; -exec bash {} \; > /proc/1/fd/1" > /etc/cron.d/cron-${CRON}
    fi
done

service cron start > /dev/null 2>&1

echo "[$(date +'%F %T')] Cron is running!"
exec $(which tail) -f /dev/null
