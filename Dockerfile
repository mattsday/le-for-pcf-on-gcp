FROM ubuntu:latest

COPY run.sh /run.sh
COPY init.sh /init.sh

RUN /init.sh

ENTRYPOINT /run.sh
