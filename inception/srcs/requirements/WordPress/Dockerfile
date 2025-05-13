FROM debian:bullseye

RUN apt-get update
RUN apt upgrade -y
RUN apt-get -y install wget
RUN apt-get install -y php7.4\
    php-fpm\
    php-mysql\
    mariadb-client\
    sendmail
    
RUN mkdir -p /var/www/html/wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN mkdir /run/php/

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d
COPY ./tools/script.sh /script.sh
RUN chmod 777 script.sh

CMD ["./script.sh"]
