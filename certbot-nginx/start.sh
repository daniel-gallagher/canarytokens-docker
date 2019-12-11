echo  "----------------------------------------------------------------"
echo  "Starting nginx and lets encrypt setup using"
echo  "Domain : $MY_DOMAIN_NAME"
echo  "Email  : $EMAIL_ADDRESS"
echo  "Staging  : $STAGING"
echo  "----------------------------------------------------------------"

sed -i "s/___my.example.com___/$MY_DOMAIN_NAME/g" /etc/nginx/nginx.conf

openssl x509 -in /etc/letsencrypt/live/$MY_DOMAIN_NAME/cert.pem -checkend 604800 > /dev/null 2>&1

# Enable staging mode if needed
if [ $STAGING != "0" ]; then staging_arg="--staging"; fi

if [ $? -eq 0 ]; then
  echo "Certificate is already present and won't expire in the next week, skipping renewal"
  cp /etc/letsencrypt/nginx.conf /etc/nginx/nginx.conf
else
  echo "Fetching certificate from LetsEncrypt"
  nginx
  sleep 5
  certbot $staging_arg --nginx -d $MY_DOMAIN_NAME -d www.$MY_DOMAIN_NAME --text --agree-tos --email $EMAIL_ADDRESS -v -n
  nginx -s stop
  cp /etc/nginx/nginx.conf /etc/letsencrypt/nginx.conf
  sleep 3
fi

nginx -g "daemon off;"
