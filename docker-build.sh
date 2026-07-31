#!/bin/sh
# local build wrapper
set -e

docker build --build-arg RSYSLOG_VERSION="$(cat version.txt | tr -d '[:space:]')" -t rsyslog:dev "$@" .
