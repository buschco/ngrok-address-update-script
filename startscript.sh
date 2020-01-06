#!/bin/sh
# start ngrok
./ngrok tcp 22 --log=stdout > ngrok.log &
# so hacky...
sleep 20
# send ip and port to circleci
curl -s http://localhost:4040/api/tunnels |
jq -r .tunnels[0].public_url |
sed -e 's/tcp:\/\/*//; s/:.*//; s/^/name=PI_IP\nvalue=/' |
jo |
tee \
# homebridge-config
>(curl -H "Content-Type: application/json" \
-X POST \
--url https://circleci.com/api/v1.1/project/github/buschco/homebridge-config/envvar?circle-token=$CIRCLECI_TOKEN \
-d @-) \
# latex
>(curl -H "Content-Type: application/json" \
-X POST \
--url https://circleci.com/api/v1.1/project/github/buschco/latex/envvar?circle-token=$CIRCLECI_TOKEN \
-d @-)

curl -s http://localhost:4040/api/tunnels |
jq -r .tunnels[0].public_url |
sed -e 's/tcp:\/\/*//; s/.*://; s/^/name=PI_PORT\nvalue=/' |
jo |
tee \
# homebridge-config
>(curl -H "Content-Type: application/json" \
-X POST \
--url https://circleci.com/api/v1.1/project/github/buschco/homebridge-config/envvar?circle-token=$CIRCLECI_TOKEN \
-d @-)
# latex
>(curl -H "Content-Type: application/json" \
-X POST \
--url https://circleci.com/api/v1.1/project/github/buschco/latex/envvar?circle-token=$CIRCLECI_TOKEN \
-d @-)
