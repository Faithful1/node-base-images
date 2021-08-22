#!/bin/bash

# docker build --pull \
#   -t sda/alpine-node:C/alpine-node:$tag  \
#   -t sda/alpine-node:14.15 \
#   -t sda/alpine-node:14.15.0 \
#   -t sda/alpine-node:latest \
#   . --network=host


for tag in 14.15 14.15.0 latest ; do
  docker build --pull -t sda/alpine-node:$tag .
done
