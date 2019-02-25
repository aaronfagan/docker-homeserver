#!/bin/bash
set -e

ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
echo "$TZ" > /etc/timezone && \
dpkg-reconfigure -f noninteractive tzdata > /dev/null 2>&1

BOOT_FILE="/opt/.first_boot_false"
if [ ! -e $BOOT_FILE ]; then
	rm -rf /etc/nginx/sites-enabled/*
	cp -rfun /opt/config/nginx/sites-enabled/* /etc/nginx/sites-enabled
	rm -rf /var/www/*
	cp -rfun /opt/config/www/* /var/www
	sed -i "s\;date.timezone =\date.timezone = \""$TZ"\"\g" /etc/php/7.3/fpm/php.ini
	sed -i "s\.*error_log = syslog\error_log = error_log\g" /etc/php/7.3/fpm/php.ini
	mkdir -p "$(dirname "$BOOT_FILE")"
	touch "$BOOT_FILE"
fi

service php7.3-fpm start

echo "WWW is running!"

# KEEP SERVER RUNNING
exec $(which nginx) -c /etc/nginx/nginx.conf -g "daemon off;"