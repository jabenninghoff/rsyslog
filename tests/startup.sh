#!/bin/sh
# check rsyslog startup and version output
# requires: docker-build.sh

STARTUP_LOG="$(mktemp)"

docker run --rm --hostname rsyslog.test rsyslog:dev sh | tee "${STARTUP_LOG}"

if [ "$(tail -1 "${STARTUP_LOG}" | cut -d' ' -f4-6)" != "entrypoint script complete" ]
then
	echo "entrypoint script did not complete"
	rm "${STARTUP_LOG}"
	exit 1
else
	rm "${STARTUP_LOG}"
fi
