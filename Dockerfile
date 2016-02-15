###
#
# A ubuntu based ETL using Compose's open-sourced "Transporter"
#
###
FROM ubuntu:14.04

RUN curl -L https://github.com/compose/transporter/releases/download/v0.1.1/transporter_linux_amd64.tar.gz > transporter.tar.gz && \
    tar -zxf transporter.tar.gz -C /usr/local

ENTRYPOINT ["transporter", "eval", "${PIPELINE}"]
