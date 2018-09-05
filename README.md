# Kong API management in Docker.

__Summary__:

- [Introduction](#introduction)
- [Description](#description)
- [Install](#install)
- [How to use it?](#how-to-use-it?)
- [Documentation](#documentation)
- [Reference](#reference)

## Introduction

This project is an example for a medium article about Kong Apis manager.<Link article>

Kong is used to proxify APIs easily. In this example 3 flask rest apis are up in the docker-compose.yml. Their adresses are then proxified with Kong and multiple rules are added, one for each api.

The kong part is a copy of the docker-compose provided by kong ([link](https://github.com/Kong/docker-kong/tree/master/compose)) in which I included the work of PGBI ([link](https://github.com/PGBI/kong-dashboard)).

## Description

Required:
  - docker
  - docker-compose
  - curl

APIs:
  - `flask-api-no-auth` doesn't need special authentification.
  - `flask-api-auth-key` requieres an authentification key.
  - `flask-api-auth-basic` requires basic authentification with username/password.
> APIs are not exposed. You only can access to them via Kong

## install

install platform:
```
make
```
> more information about available commands with makefile in documentation section.

You can verify the status of services:
```SHELL
$ make ps;

docker-compose ps
                Name                              Command                  State                                                     Ports                                               
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
kong-api-auth_consul_1                 /bin/start -server -bootst ...   Up (healthy)   53/tcp, 53/udp, 8300/tcp, 8301/tcp, 8301/udp, 8302/tcp, 8302/udp, 8400/tcp, 0.0.0.0:8500->8500/tcp
kong-api-auth_flask-api-auth-basic_1   python -u /api/app.py            Up                                                                                                               
kong-api-auth_flask-api-auth-key_1     python -u /api/app.py            Up                                                                                                               
kong-api-auth_flask-api-no-auth_1      python -u /api/app.py            Up                                                                                                               
kong-api-auth_kong-database_1          docker-entrypoint.sh postgres    Up (healthy)   5432/tcp                                                                                          
kong-api-auth_kong-migration_1         /docker-entrypoint.sh kong ...   Exit 0                                                                                                           
kong-api-auth_kong_1                   sh /entrypoint.sh                Up (healthy)   7946/tcp, 0.0.0.0:8000->8000/tcp, 0.0.0.0:8001->8001/tcp, 8443/tcp, 8444/tcp                      
kong-dashboard                         ./docker/entrypoint_dev.sh       Up             0.0.0.0:8080->8080/tcp
```
## How to use ?

Once the platform is up, each services are up except the migration one that is normally exited.
You can do GET requests to 3 different APIs with 3 different authentification processes.

**no-aut.com**:

routes:
  - /
  - /json
  - /text

Get:

`curl -L -i -X GET http://0.0.0.0:8000/no-auth/ --header 'Host: no-auth.com'`

---
**key-aut.com**:

routes:
  - /
  - /json
  - /text

Get:

`curl -L -i -X GET http://0.0.0.0:8000/key-auth/ --header 'Host: no-auth.com'`

---
**basic-aut.com**:

routes:
  - /
  - /json
  - /text

  Get:

  `curl -L -i -X GET http://0.0.0.0:8000/no-auth/ --header 'Host: no-auth.com'`

---

You can also configure and manage your APIs in a browser at: http://localhost:8080

or

You can directly manage your apis with the kong administration api at: http://localhost:8001/

example:
  This command registers an API:
  ```
  curl -i -X POST --url http://kong:8001/apis/ --data 'name=my_new_api' --data 'uris=/new_api' --data 'hosts=new-api.com' --data 'upstream_url= http://randomprofile.com/api/'
  ```
  This api previously registered is a profile generator. To use it, you just have to specify the countries.
  ```
  curl -L -i -X GET http://0.0.0.0:8000/new_api/api.php?countries=GBR --header 'Host: new-api.com'
  ```
  `api.php?countries=GRB` is from the documentation of the api.([more information](https://www.programmableweb.com/api/randomprofile))

## Documentation

_Makefile commands available_:

| **commands name**  | **description**                                                      |
|:------------------:|:-------------------------------------------------------------------- |
|       `make`       | 1. down service                                                      |
|                    | 2. build service (create-repository)                                 |
|                    | 3. run service (create-repository)                                   |
|                    |                                                                      |
|    `make build`    | build service (create-repository)                                    |
|                    |                                                                      |
|     `make up`      | run project (create-repository)                                      |
|                    |                                                                      |
|    `make down`     | down project                                                         |
|                    |                                                                      |
|     `make ps`      | list container                                                       |
|                    |                                                                      |
|    `make logs`     | display all platform logs                                            |

## Reference

- [Docker](https://www.docker.com)
- [Docker-compose](https://docs.docker.com/compose/)
- [Flask](http://flask.pocoo.org/)
- [Kong website](https://konghq.com/kong-community-edition/)
- [Kong docker-compose (by Kong)](https://github.com/Kong/docker-kong/tree/master/compose)
- [Kong dashboard (by PGBI)](https://github.com/PGBI/kong-dashboard)
- [Example API](https://www.programmableweb.com/api/randomprofile)
