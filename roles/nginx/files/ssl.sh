#!/bin/bash

mkdir -p /etc/nginx/ssl

openssl req -x509 -sha256 -nodes -newkey rsa:2048 \
  -keyout /etc/nginx/ssl/nginx-selfsigned.key \
  -out /etc/nginx/ssl/nginx-selfsigned.crt \
  -days 365 \
  -subj "/C=MA/ST=elhajeb/L=elhajeb/O=1337/OU=daira5/CN=mazhari.42.fr"