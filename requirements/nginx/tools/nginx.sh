#!bin/bash

#define certificates and key paths:
CERT_PATH="/etc/nginx/certs/cer.pem"
KEY_PATH="/etc/ngnix/certs/key.pem"


#checking if the certificate and key already exist 
if [! -f "$CERT_PATH"] || [! -f "$KEYPATH" ]; then
    echo "Sir  , we are Generating SSL certificate and key ... "
    mkdir -p /etc/ngnix/certs  /etc/nginx/private
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout "$KEY_PATH" -out "$CERT_PATH" \
    -subj "/C=US/ST=State/L=City/O=Organization/OU=Department/CN=mboudrio.42.fr"
    echo "Sir , Certificate and key generated."
fi

