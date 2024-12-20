#!/bin/bash

PEER=rp2

. ./common.sh

openvpn --tls-crypt-v2 rp-server-v2.key --genkey tls-crypt-v2-client client-v2.key
# Replace the fingerprint in the following command with the one displayed by the `setup-server.sh` script
sudo openvpn --remote server --tls-client --dev tun1 --ifconfig 10.4.0.2 10.4.0.1 --cipher AES-256-GCM --cert client.crt --key client.key --peer-fingerprint "15:41:62:46:C8:78:A4:A5:7B:CB:1A:7D:FF:72:4E:D6:64:B7:CC:50:A7:97:25:DF:BA:72:E3:81:71:41:DE:2E" --tls-crypt-v2 client-v2.key