#!/bin/sh
# start ngrok
killall ngrok
./ngrok tcp 22 --log=stdout > ngrok.log &
# so hacky...
sleep 20
# send ip and port to urls
IP=$(curl -s http://localhost:4040/api/tunnels |
jq -r .tunnels[0].public_url |
sed -e 's/tcp:\/\/*//; s/:.*//; s/^/name=PI_IP\nvalue=/' |
jo)

PORT=$(curl -s http://localhost:4040/api/tunnels |
jq -r .tunnels[0].public_url |
sed -e 's/tcp:\/\/*//; s/.*://; s/^/name=PI_PORT\nvalue=/' |
jo)

while read url; do
    echo "Posting IP: $IP to $url"
    curl -H "Content-Type: application/json" \
        -X POST \
        --url $url \
        -d $IP
    echo "Posting PORT: $PORT to $url"
    curl -H "Content-Type: application/json" \
        -X POST \
        --url $url \
        -d $PORT
done <urls.txt
