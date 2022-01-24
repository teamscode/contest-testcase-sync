FROM mirror.gcr.io/library/alpine:3

RUN apk add --update --no-cache rsync

COPY ./entrypoint.sh /deploy/entrypoint.sh
COPY ./rsyncd.conf /etc/rsyncd.conf

ENTRYPOINT /deploy/entrypoint.sh