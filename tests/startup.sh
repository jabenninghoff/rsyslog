#!/bin/sh
# check rsyslog startup and version output
# requires: docker-build.sh
set -e

docker run --rm --hostname rsyslog.test rsyslog:dev rsyslogd -N1
