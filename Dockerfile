###
#
# A ubuntu based ETL using Compose's open-sourced "Transporter"
#
###
FROM ubuntu:14.04
MAINTAINER Francis Dortort <francis@dortort.com>

ENV TRANSPORTER_VERSION 0.1.1
ENV TRANSPORTER_TAG v${TRANSPORTER_VERSION}

RUN DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -qy --no-install-recommends curl ca-certificates && \
    apt-get autoremove --purge && \
    apt-get clean

RUN curl --verbose -SLO "https://github.com/compose/transporter/releases/download/${TRANSPORTER_TAG}/transporter_linux_amd64.tar.gz" \
    && tar -zxf "transporter_linux_amd64.tar.gz" -C /usr/local/bin --strip-components=1 \
    && rm "transporter_linux_amd64.tar.gz"

COPY ./docker-entrypoint.sh /

RUN chmod 700 /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
