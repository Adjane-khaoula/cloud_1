FROM mariadb:11.8.1-noble-rc

COPY ./config/launch_script.sh /launch_script.sh
COPY ./config/updateDb.sh /updateDb.sh

RUN chmod +x /launch_script.sh /updateDb.sh && \
    apt-get update && \
    apt-get install -y vim netcat-traditional && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/sh", "-c", "/launch_script.sh"]
