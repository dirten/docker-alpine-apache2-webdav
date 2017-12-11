FROM alpine:3.7

ENV LANG en_US.utf8

RUN apk add --update curl apache2-webdav apache2-ssl apache2-ctl apache2-utils && \
    curl -Ls -o /tmp/s6-overlay.tar.gz https://github.com/just-containers/s6-overlay/releases/download/v1.21.2.1/s6-overlay-amd64.tar.gz \
    && tar xvfz /tmp/s6-overlay.tar.gz -C / \
    && rm -f /tmp/s6-overlay.tar.gz \
    && apk del curl \
    && deluser xfs \
    && delgroup www-data \
    && rm -rfv /var/cache/apk/*
ADD files.tar /
ENTRYPOINT ["/init"]
EXPOSE 80
EXPOSE 443
