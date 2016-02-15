FROM ubuntu:14.04

ENTRYPOINT ["/transporter", "eval", "${PIPELINE}"]
