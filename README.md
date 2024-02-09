# PostgreSQL Extended

## Summary

This repo contains the Dockerfile and supplementary files for building a Postgres image including some useful extensions

### Extensions installed:

- [pg_cron](https://github.com/citusdata/pg_cron)
- [pg_repack](https://github.com/reorg/pg_repack)

## Details

This image was originally derived from official [postgres:14-alpine](https://hub.docker.com/_/postgres) docker image with some modifications since.

[docker-entrypoint.sh](docker-entrypoint.sh) is directly from [docker-library](https://github.com/docker-library/postgres/blob/master/14/alpine/docker-entrypoint.sh).

A pre-built image is available from GHCR [here](https://github.com/ChrisLovering/psql_pg_cron/pkgs/container/psql_pg_cron).


## Post deployment steps

### pg_cron
Add the following to the bottom of your postgresql.conf file, replacing `my_database` with the name of the database to make pg_cron available in, making sure to reboot postgres after doing so.

This can't be done within this base image itself, as that would stop it from working within docker-compose.

```
shared_preload_libraries = 'pg_cron'
cron.database_name = 'my_database'
```

You can then enable the pg_cron extension on that database by running the following within that database. 

```sql
CREATE EXTENSION pg_cron;
```

### pg_repack
Run the following on the database you want pg_repack to be available in.

```sql
CREATE EXTENSION pg_repack;
```
