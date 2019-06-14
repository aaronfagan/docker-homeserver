FROM ubuntu:18.04

ENV TZ=America/Edmonton

RUN apt-get update && \
	apt-get install -y \
		software-properties-common
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update && \
	apt-get install -y \
		nano \
		nginx \
		php7.3 \
		php7.3-common \
		php7.3-curl \
		php7.3-fpm \
		php7.3-gd \
		php7.3-mbstring \
		php7.3-mysql \
		php7.3-xml \
		php7.3-zip

COPY ./config /opt/config
COPY ./config/entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 8080/tcp

ENTRYPOINT ["/sbin/entrypoint.sh"]

CMD ["mysql start && /usr/sbin/nginx"]