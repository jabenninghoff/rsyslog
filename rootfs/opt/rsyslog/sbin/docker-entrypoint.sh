#!/bin/sh
set -e

entrypoint_log() {
    echo "rsyslog: $*"
}

entrypoint_log "version ${RSYSLOG_VERSION:-unknown} starting"

# shellcheck disable=SC3028
entrypoint_log "using HOSTNAME ${HOSTNAME:-unknown}"

entrypoint_log "checking rsyslogd configuration"
rsyslogd -N1

exec "$@"
