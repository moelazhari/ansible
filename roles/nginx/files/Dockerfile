FROM debian:bullseye

RUN apt update -y \
    && apt install nginx openssl -y \
    && rm -rf /var/lib/apt/lists/*

COPY /nginx.conf /etc/nginx/

COPY /ssl.sh .

RUN chmod +x ./ssl.sh \
    && ./ssl.sh

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]