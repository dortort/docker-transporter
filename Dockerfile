###
#
# A ubuntu based ETL using Compose's open-sourced "Transporter"
#
###
FROM ubuntu:14.04

WORKDIR /usr/local/transporter_linux_amd64

RUN DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -qy --no-install-recommends curl ca-certificates && \
    apt-get autoremove --purge && \
    apt-get clean

RUN curl -kL https://github.com/compose/transporter/releases/download/v0.1.1/transporter_linux_amd64.tar.gz > transporter.tar.gz && \
    tar -zxf transporter.tar.gz -C /usr/local

COPY ./docker-entrypoint.sh /

RUN chmod 700 /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
