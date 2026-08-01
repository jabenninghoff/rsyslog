#!/bin/sh
set -e

entrypoint_log() {
    # match rsyslog format
    echo "$(date +'%Y-%m-%d %H:%M:%S') rsyslog: $*"
}

entrypoint_log "version ${RSYSLOG_VERSION:-unknown} starting"

# shellcheck disable=SC3028
entrypoint_log "using HOSTNAME ${HOSTNAME:-unknown}"

entrypoint_log "checking rsyslogd configuration"
rsyslogd -N1

exec "$@"
