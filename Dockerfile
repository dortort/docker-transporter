###
#
# A centos based ETL using Compose's open-sourced "Transporter"
#
###
FROM centos:7
MAINTAINER Francis Dortort <francis@dortort.com>

RUN yum install -yq golang git

RUN mkdir -p /opt/go
ENV GOPATH /opt/go
RUN cd /opt/go
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

WORKDIR /opt/go/bin

COPY ./docker-entrypoint.sh /

RUN chmod 700 /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
