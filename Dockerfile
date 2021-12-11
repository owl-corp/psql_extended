FROM postgres:14-alpine

RUN apk add postgresql-pg_cron --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod a+x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]