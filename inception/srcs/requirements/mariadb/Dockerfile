# FROM debian:bullseye

# RUN apt-get update
# RUN apt-get install -y mariadb-server

# COPY ./tools/script.sh /script.sh
# RUN chmod 777 script.sh

# CMD ["bash", "script.sh"]
FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

COPY ./tools/script.sh /script.sh
RUN chmod +x /script.sh

CMD ["bash", "/script.sh"]
