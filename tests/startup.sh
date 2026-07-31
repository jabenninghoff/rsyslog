#!/bin/sh
# check rsyslog startup and version output
# requires: docker-build.sh

docker run --rm --hostname rsyslog.test rsyslog:dev sh
