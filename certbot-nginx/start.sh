echo  "----------------------------------------------------------------"
echo  "Starting nginx and lets encrypt setup using"
echo  "Domain : $MY_DOMAIN_NAME"
echo  "Email  : $EMAIL_ADDRESS"
echo  "Staging  : $STAGING"
echo  "----------------------------------------------------------------"

sed -i "s/___my.example.com___/$MY_DOMAIN_NAME/g" /etc/nginx/nginx.conf

# Enable staging mode if needed
if [ $STAGING != "0" ]; then staging_arg="--staging"; fi

nginx
sleep 5

./certbot $staging_arg --nginx -d $MY_DOMAIN_NAME -d www.$MY_DOMAIN_NAME --text --agree-tos --email $EMAIL_ADDRESS -v -n

nginx -s stop
sleep 3

nginx -g "daemon off;"
