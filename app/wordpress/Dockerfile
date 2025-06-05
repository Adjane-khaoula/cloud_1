FROM wordpress:6.7.2-php8.1-fpm-alpine

COPY config/launch_script.sh /launch_script.sh

RUN chmod +x /launch_script.sh && \
    apk add --no-cache wget && \
    wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz --strip-components=1 && \
    rm -rf latest.tar.gz /var/cache/apk/*

ENTRYPOINT ["sh", "/launch_script.sh"]

