FROM nginx

RUN echo "deb http://deb.debian.org/debian stretch-backports main" | tee -a /etc/apt/sources.list
RUN apt-get update && apt-get install -y certbot python-certbot-nginx -t stretch-backports

COPY nginx.conf /etc/nginx/nginx.conf
#COPY .htpasswd /etc/nginx/.htpasswd
COPY start.sh /tmp

RUN chmod a+x /tmp/start.sh

ENTRYPOINT [ "bash", "-c", "/tmp/start.sh" ]
