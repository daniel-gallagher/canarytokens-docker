FROM nginx

RUN apt-get update && apt-get install -y certbot python-certbot-nginx -t stretch-backports

COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /
CMD /start.sh
