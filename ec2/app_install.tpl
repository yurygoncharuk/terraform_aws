#!/bin/bash

apt-get update
export DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq
apt-get install -y ${application}
