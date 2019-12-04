#!/bin/bash
set -e

ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
echo "${TZ}" > /etc/timezone && \
dpkg-reconfigure -f noninteractive tzdata > /dev/null 2>&1
sed -i "s\;date.timezone =\date.timezone = \""${TZ}"\"\g" /etc/php/7.3/fpm/php.ini
sed -i "s\.*error_log = syslog\error_log = error_log\g" /etc/php/7.3/fpm/php.ini

service php7.3-fpm start
echo "WWW is running!"
exec $(which nginx) -c /etc/nginx/nginx.conf -g "daemon off;"