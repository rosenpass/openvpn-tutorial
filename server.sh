#!/bin/bash

PEER=rp1

. ./common.sh

# Replace the fingerprint in the following command with the one displayed by the `setup-client.sh` script
sudo openvpn --ifconfig 10.4.0.1 10.4.0.2 --tls-server --dev tun1 --dh dh2048.pem --cert server.crt --key server.key --cipher AES-256-GCM --peer-fingerprint "96:93:87:7A:1C:31:0B:7F:3F:20:27:9C:DC:85:86:3F:4F:CC:A2:74:EA:0D:2B:FE:0A:65:A7:D4:D1:20:91:36" --tls-crypt-v2 rp-server-v2.key --verb 2