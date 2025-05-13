FROM debian:bullseye

RUN apt-get update 
RUN apt-get install -y nginx
RUN apt-get install openssl


COPY ./tools/certificate.crt /etc/ssl/
COPY ./tools/private.key /etc/ssl/

COPY ./conf/default.conf /etc/nginx/conf.d/
CMD ["nginx", "-g", "daemon off;"]
