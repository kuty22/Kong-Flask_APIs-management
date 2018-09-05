#!/bin/sh
set -e

/bin/containerpilot kong start --run-migrations

sleep 20

####################################################################################################
# no-auth.com
####################################################################################################

# Register API
curl -i -X POST --url http://kong:8001/apis/ --data 'name=api-no-auth' --data 'uris=/no-auth' --data 'hosts=no-auth.com' --data 'upstream_url=http://flask-api-no-auth:8241'


####################################################################################################
# key-auth.com
####################################################################################################

# Register API
curl -i -X POST --url http://kong:8001/apis/ --data 'name=api-key-auth' --data 'uris=/key-auth' --data 'hosts=key-auth.com' --data 'upstream_url=http://flask-api-key-auth:8241'
# Set plugins for the api registred before
curl -i -X POST --url http://localhost:8001/apis/api-key-auth/plugins/ --data 'name=key-auth'
# Create user
curl -i -X POST --url http://localhost:8001/consumers/ --data "username=Jason"
# Create keys for Jason
curl -i -X POST http://kong:8001/consumers/Jason/key-auth -d 'key=key_password'


####################################################################################################
# key-auth.com
####################################################################################################

# Register API
curl -i -X POST --url http://kong:8001/apis/ --data 'name=api-basic-auth' --data 'uris=/baic-auth' --data 'hosts=basic-auth.com' --data 'upstream_url=http://flask-api-basic-auth:8241'
# set plugins for the api registred before
curl -i -X POST --url http://localhost:8001/apis/api-basic-auth/plugins/  --data "name=basic-auth"  --data "config.hide_credentials=true"
# Create user
curl -i -X POST --url http://localhost:8001/consumers/ --data "username=Brandon" --data "custom_id=brandon_id"
# Add plugin consumers
curl -X POST http://kong:8001/consumers/Brandon/basic-auth --data "username=Aladdin" --data "password=OpenSesame"


tail -f /dev/null
