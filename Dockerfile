ARG postgres_version=15

FROM postgres:$postgres_version-alpine

ENV PG_CRON_VERSION=1.4.2 \
    PG_REPACK_VERSION=1.4.8

# Install build deps
RUN apk add --no-cache --virtual .build-deps cmake build-base wget postgresql-dev lz4-dev zlib-dev gawk

#Download, build & install pg_cron
RUN mkdir /cron_build && \
    cd /cron_build && \
    wget https://github.com/citusdata/pg_cron/archive/v$PG_CRON_VERSION.tar.gz && \
    tar xzvf v$PG_CRON_VERSION.tar.gz && \
    cd pg_cron-$PG_CRON_VERSION && \
    make && \
    make install

#Download, build & install pg_repack
RUN mkdir /repack_build && \
    cd /repack_build && \
    wget https://api.pgxn.org/dist/pg_repack/$PG_REPACK_VERSION/pg_repack-$PG_REPACK_VERSION.zip && \
    unzip pg_repack-$PG_REPACK_VERSION.zip && \
    cd pg_repack-$PG_REPACK_VERSION && \
    make && \
    make install

# Clean up:
RUN cd / && \
    rm -rf /cron_build && \
    rm -rf /repack_build && \
    apk del .build-deps

COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod a+x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]
