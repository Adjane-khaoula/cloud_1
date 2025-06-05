FROM adminer:5

USER root

RUN apk update && apk add --no-cache vim mysql-client

USER	adminer

ENTRYPOINT ["php", "-S", "[::]:8080", "-t", "/var/www/html"]
