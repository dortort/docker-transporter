###
#
# A golang based ETL using Compose's open-sourced "Transporter"
#
###
FROM golang:1.6-onbuild
MAINTAINER Francis Dortort <francis@dortort.com>

RUN mkdir -p /go
ENV GOPATH /go
RUN cd /go
RUN go get github.com/tools/godep
RUN bin/godep restore
RUN bin/godep go build -a ./cmd/...
RUN mkdir -p src/github.com/compose pkg bin
RUN cd src/github.com/compose
RUN git clone https://github.com/ndouba/transporter
RUN cd transporter
RUN git checkout patch-1
RUN go get -a ./cmd/...
RUN go build -a ./cmd/...

WORKDIR /go/bin

COPY ./docker-entrypoint.sh /

RUN chmod 700 /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
