# PostgreSQL + pg_cron

Dockerfile for building Postgres with the [pg_cron](https://github.com/citusdata/pg_cron) extension from citrusdata.

This image is derived from official [postgres:14-alpine](https://hub.docker.com/_/postgres) docker image. [docker-entrypint.sh](docker-entrypoint.sh) is directly from [docker-library](https://github.com/docker-library/postgres/blob/master/14/alpine/docker-entrypoint.sh).

A pre-build image of this Dockerfile is available from GHCR [here](https://github.com/ChrisLovering/psql_pg_cron/pkgs/container/psql_pg_cron).

Once deployed, you can add the pg_cron extension to the database of choice by connecting to the DB and running 

```sql
CREATE EXTENSION pg_cron
```
