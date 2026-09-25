FROM alpine:3.24.2@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6

# rsyslog 8.2604.0-r0
# major updates are features, other updates are fixes
RUN apk upgrade --no-cache && \
    apk add --no-cache rsyslog

ARG RSYSLOG_VERSION
ENV RSYSLOG_VERSION="${RSYSLOG_VERSION}"

# save alpine default rsyslog configuration for snapshot testing
RUN cp -p /etc/rsyslog.conf /etc/rsyslog.conf.dist
COPY rootfs/ /

EXPOSE 514/udp 514/tcp
VOLUME [ "/var/log" ]

ENTRYPOINT [ "/opt/rsyslog/sbin/docker-entrypoint.sh" ]
CMD [ "rsyslogd", "-n" ]
