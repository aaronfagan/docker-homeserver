FROM ubuntu:18.04

ENV AWS_REGION="us-west-2"
ENV AWS_OUTPUT="json"
ENV TZ=America/New_York

RUN apt-get update && \
	apt-get install -y \
		software-properties-common
RUN add-apt-repository ppa:certbot/certbot
RUN apt-get update && \
	apt-get install -y \
		apache2-utils \
		awscli \
		certbot \
		cron \
		nano \
		nginx \
		python3-certbot-dns-route53

COPY ./config /opt/config
COPY ./config/entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 80/tcp 443/tcp

ENTRYPOINT ["/sbin/entrypoint.sh"]

CMD ["/usr/sbin/nginx"]