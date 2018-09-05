# Docker blih Epitech.

__Summary__:

- [Introduction](#introduction)
- [Description](#description)
- [Install](#install)
- [How to use it?](#how-to-use-it?)
- [Documentation](#documentation)
- [Reference](#reference)

## Introduction

This project is an example for a medium article about Kong Apis manager.<Link article>

Kong is used to proxify APIs easely. In this example 3 flask rest api are up in the docker-compose.yml
then I proxify their address with Kong and add multiple rules, one differents for each api.

The kong part is a copy of the docker-compose propose by kong (link to offical kong docker repository) in wich I include the work of PGBI (link to his repository).

## Description

Required:
  - docker
  - docker-compose
  - curl

APIs:
  - `flask-api-no-auth` doesn't need special authentification.
  - `flask-api-auth-key` requiered an authentification key.
  - `flask-api-auth-basic` required an Basic authentification username/password.
> APIs are not exposed you only can access to them by Kong

## install

install platform:
```
make
```
> more informations about available command with makefile in documentation section.

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
## How to use it?

Once, the platform is up, each services except the migration one that is normaly exit.
you can get 3 different APIs, which are requiered specific authentification process.

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

You can directly manage by the adress of the kong administration at: http://localhost:8001/

example:
  This commande register an API:
  ```
  curl -i -X POST --url http://kong:8001/apis/ --data 'name=my_new_api' --data 'uris=/new_api' --data 'hosts=new-api.com' --data 'upstream_url= http://randomprofile.com/api/'
  ```
  This api previously registred is a profile generator you just have to specify the counties.
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

- [Docker hub Ubuntu](https://hub.docker.com/_/ubuntu/)
- [Docker](https://www.docker.com)
- [Docker-compose](https://docs.docker.com/compose/)
