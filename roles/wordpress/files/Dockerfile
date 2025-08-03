FROM debian:bullseye

RUN apt update -y\
    && apt install curl php-fpm php-mysql mariadb-client sendmail netcat -y\
    && rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar\ 
    && chmod +x wp-cli.phar\
    && mv wp-cli.phar /usr/local/bin/wp \
    && mkdir -p /var/www/html && cd /var/www/html\
    && wp core download --force --allow-root

COPY ./www.conf /etc/php/7.4/fpm/pool.d 

COPY ./wp.sh .

RUN chmod +x ./wp.sh

ENTRYPOINT ["./wp.sh"]
CMD ["/usr/sbin/php-fpm7.4", "-F"]