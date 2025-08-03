FROM debian:bullseye

RUN apt update -y \
&& apt install nginx -y

COPY /nginx.conf /etc/nginx/

COPY ./sslCert /home/sslCert

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]