#!/bin/sh
# check for changes to rsyslog default configuration
# requires: docker-build.sh

DOCKER_RUN='docker run --rm --hostname rsyslog.test --entrypoint sh'
IMAGE='rsyslog:dev'
COMMAND='cat /etc/rsyslog.conf.dist'
SNAPSHOT='snapshot-rsyslog-defaults.txt'

if command -v colordiff >/dev/null 2>&1
then
	DIFF='colordiff'
else
	DIFF='diff'
fi

[ -f "$SNAPSHOT" ] || touch "$SNAPSHOT"

if ! $DOCKER_RUN "$IMAGE" -c "$COMMAND" | "$DIFF" -u "$SNAPSHOT" -
then
	echo "snapshot using: $DOCKER_RUN $IMAGE -c '$COMMAND' >$SNAPSHOT"
	echo "$DOCKER_RUN $IMAGE -c '$COMMAND' >$SNAPSHOT" | pbcopy
	exit 1
fi
