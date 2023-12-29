#!/bin/sh

cat <<EOF >ServerConfig.toml
[General]
Description = "${Description}"
Debug = ${Debug} # true or false to enable debug console output
Private = ${Private} # Private?
Port = ${Port} # Port to run the server on UDP and TCP
MaxCars = ${MaxCars} # Max cars for every player
MaxPlayers = ${MaxPlayers} # Maximum Amount of Clients
Map = "${Map}" # Default Map
Name = "${Name}" # Server Name
use = "${use}" # Resource file name
AuthKey = "${AuthKey}" # Auth Key
EOF

exec ./BeamMP-Server "$@"
