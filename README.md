# Rosenpass with OpenVPN

This repository contains the following files:
* `setup-server.sh` and `setup-client.sh` that generate Rosenpass keypairs, TLS certificates and
   public parameters for OpenVPN,
* `server.sh` and `client.sh` that start the Rosenpass and OpenVPN connections on the respective sides, and
* `common.sh` that is included by `server.sh` and `client.sh` to take care of deriving the OpenVPN tls-crypt-v2 server key
  from the Rosenpass shared secret, with the code described in the previous section.
* `rp1` and `rp2`: configuration files for the two Rosenpass peers
