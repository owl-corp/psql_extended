FROM postgres:14-alpine

ENV PG_CRON_VERSION 1.4.1

# Download, build & install pg_cron
RUN apk add --no-cache --virtual .build-deps \
    cmake build-base wget postgresql-dev && \
    mkdir /build && \
    cd /build && \
    wget https://github.com/citusdata/pg_cron/archive/v$PG_CRON_VERSION.tar.gz && \
    tar xzvf v$PG_CRON_VERSION.tar.gz && \
    cd pg_cron-$PG_CRON_VERSION && \
    make && \
    make install && \
# Clean up:
    cd / && \
    rm -rf /build && \
    apk del .build-deps

COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod a+x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]
