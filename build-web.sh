#!/bin/bash
# USAGE:
# build-tc-web.sh
#
# NOTE:
# Rebuild the Taxicode Web Docker image composition.

docker-compose build --no-cache php-7-4-web-server \
&& docker-compose up -d