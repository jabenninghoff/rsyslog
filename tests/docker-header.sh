#!/bin/sh
# requires: updated snapshot-apk.txt
# build Dockerfile version header

grep -E '^rsyslog ' snapshot-apk.txt | xargs | sed 's/^/# /' | pbcopy
