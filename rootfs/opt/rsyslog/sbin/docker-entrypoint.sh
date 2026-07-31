#!/bin/sh
set -e

entrypoint_log() {
    echo "rsyslog: $*"
}

entrypoint_log "version ${RSYSLOG_VERSION:-unknown} starting"

# shellcheck disable=SC3028
entrypoint_log "using HOSTNAME ${HOSTNAME:-unknown}"

# TODO: implement configuration validation, per https://docs.rsyslog.com/doc/containers/minimal.html

exec "$@"
