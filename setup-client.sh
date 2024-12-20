#!/bin/bash

rosenpass gen-keys rp2

openssl req -x509 -newkey ec:<(openssl ecparam -name secp521r1) -keyout client.key -out client.crt -nodes -sha256 -days 365 -subj '/CN=client'

openssl x509 -fingerprint -sha256 -in client.crt -noout
echo "Please copy-paste this fingerprint into server.sh"
echo "Please copy the file rp2-public-key to the server"