## Goals

Deploy SQL Scripts to SQL Server.  This is done by spawning a `sql server` container in docker.  A further `sql-script-runner` container is spun up to execute scripts against the sql server.

## Getting Started

Run the following from the `root folder` of this project:

### SQL

```console
docker-compose -f docker/sql/docker-compose.yml -p sql-dont-work down --remove-orphans 
docker-compose -f docker/sql/docker-compose.yml build --force-rm --no-cache sql-script-runner-3
docker-compose -f docker/sql/docker-compose.yml -p sql-dont-work up --build
```

### Hello

```console
docker-compose -f docker/hello/docker-compose.yml -p hello-world down --remove-orphans 
docker-compose -f docker/hello/docker-compose.yml build --force-rm --no-cache --progress=plain hello-world-container
docker-compose -f docker/hello/docker-compose.yml -p hello-world up --build
```

### ARGS

```console
docker-compose -f docker/args/docker-compose.yml -p hello-world down --remove-orphans 
docker-compose -f docker/args/docker-compose.yml build --force-rm --no-cache --progress=plain hello-world-container
docker-compose -f docker/args/docker-compose.yml -p hello-world up --build
```

### ARGS 2

Demonstrates multi line.

```console
docker-compose -f docker/args-multi-line/docker-compose.yml -p hello-world down --remove-orphans 
docker-compose -f docker/args-multi-line/docker-compose.yml build --force-rm --no-cache --progress=plain hello-world-container
docker-compose -f docker/args-multi-line/docker-compose.yml -p hello-world up --build
```

## Issues

A dump of commands...

```console
docker-compose -f docker/hello/docker-compose.yml -p hello-world logs

docker build -f ./docker-hello/hello-world.dockerfile .

docker build -f ./docker-hello/hello-world.dockerfile -t hello-world .
docker run hello-world
```