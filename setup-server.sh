#!/bin/bash

rosenpass gen-keys rp1

openssl req -x509 -newkey ec:<(openssl ecparam -name secp521r1) -keyout server.key -out server.crt -nodes -sha256 -days 365 -subj '/CN=server'

openssl dhparam -out dh2048.pem 2048

openssl x509 -fingerprint -sha256 -in server.crt -noout
echo "Please copy-paste this fingerprint into client.sh"
echo "Please copy the file rp1-public-key to the client"