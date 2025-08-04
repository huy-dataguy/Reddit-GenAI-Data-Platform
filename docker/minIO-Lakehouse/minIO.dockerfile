# Sử dụng tag 'debian' thay vì 'latest-debian'
FROM minio/minio:focal
USER root
RUN apt-get update && apt-get install -y curl dos2unix && rm -rf /var/lib/apt/lists/*
RUN curl -LO https://dl.min.io/client/mc/release/linux-amd64/mc \
    && chmod +x mc \
    && mv mc /usr/local/bin/

COPY ../../../config/minIO-Lakehouse/create_bucket.sh /usr/local/bin/create_bucket.sh
RUN chmod +x /usr/local/bin/create_bucket.sh

COPY ./../../config/minIO-Lakehouse/entrypoint.sh /entrypoint.sh
RUN dos2unix /entrypoint.sh && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]