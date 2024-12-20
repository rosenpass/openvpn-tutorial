#!/bin/bash

# TODO refactor this such that this file defines functions

# This has to match the filename configured
# in the Rosenpass config file. Rosenpass will
# write the shared key into this file.
PSK_FILE=./${PEER}-key-out

# Remove previous PSK output file, because we use
# it to test if the first handshake completed.
rm -f $PSK_FILE

# Start Rosenpass in the background and keep the
# process ID to be able to kill the process after
# the first handshake completed.
sudo rosenpass exchange-config ${PEER} & PID=$!

echo "Starting Rosenpass with PID $PID"

# Wait for the PSK file to be created by Rosenpass.
while [ ! -f $PSK_FILE ]; do sleep 1; done

# Kill the Rosenpass process as soon as a PSK has been written
# to the PSK file.
echo -e "PSK file has been created, stopping Rosenpass process"
sudo kill $PID

PSK_HEX=$(cat $PSK_FILE | base64 -d | od -t x1 -An | tr -d ' \n')

openssl kdf -binary -out enc.bin -keylen 32 -kdfopt digest:SHA2-256 -kdfopt key:${PSK_HEX} -kdfopt info:openvpn_tls_crypt_v2_server_key_encryption HKDF
openssl kdf -binary -out auth.bin -keylen 32 -kdfopt digest:SHA2-256 -kdfopt key:${PSK_HEX} -kdfopt info:openvpn_tls_crypt_v2_server_key_authentication HKDF

openssl rand -out rand1.bin 32
openssl rand -out rand2.bin 32

cat enc.bin rand1.bin auth.bin rand2.bin > rp-server-v2.bin

echo "-----BEGIN OpenVPN tls-crypt-v2 server key-----" > rp-server-v2.key
base64 --wrap=64 rp-server-v2.bin >> rp-server-v2.key
echo "-----END OpenVPN tls-crypt-v2 server key-----" >> rp-server-v2.key

chmod 600 rp-server-v2.key
rm enc.bin auth.bin rand1.bin rand2.bin rp-server-v2.bin