#!/bin/bash

# docker build --pull \
#   -t sda/alpine-node:sda/alpine-node:$tag  \
#   -t sda/alpine-node:14.15.0 \
#   -t sda/alpine-node:14.15.1 \
#   -t sda/alpine-node:14.15.2 \
#   . --network=host


for tag in 14.15.0 14.15.1 14.15.2 latest ; do
  docker build --pull -t sda/alpine-node:$tag .
done
