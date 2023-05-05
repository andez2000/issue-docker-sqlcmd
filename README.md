## Goals

Deploy SQL Scripts to SQL Server.  This is done by spawning a `sql server` container in docker.  A further `sql-script-runner` container is spun up to execute scripts against the sql server.

## Getting Started

Run the following from the `root folder` of this project:

```console
docker-compose -f docker/docker-compose.yml down
docker-compose -f docker/docker-compose.yml build sql-script-runner
docker-compose -f docker/docker-compose.yml -p sql-dont-work up
```