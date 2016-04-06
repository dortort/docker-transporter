###
#
# A goland based ETL using Compose's open-sourced "Transporter"
#
###
FROM golang:1.6-onbuild
MAINTAINER Francis Dortort <francis@dortort.com>

ENV GOPATH /go
RUN mkdir -p /go/src/github.com/compose /go/pkg /go/bin
RUN cd /go/src/github.com/compose && git clone https://github.com/ndouba/transporter && \
    cd transporter && git checkout patch-1

RUN cd /go/src/github.com/compose/transporter && go get github.com/tools/godep
RUN cd /go/src/github.com/compose/transporter && /go/bin/godep restore
RUN cd /go/src/github.com/compose/transporter && /go/bin/godep go build -a ./cmd/...
RUN cd /go/src/github.com/compose/transporter && go get -a ./cmd/...
RUN cd /go/src/github.com/compose/transporter && go build -a ./cmd/...

WORKDIR /go/bin

COPY ./docker-entrypoint.sh /

RUN chmod 700 /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
