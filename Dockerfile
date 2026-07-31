FROM alpine:3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b

# rsyslog 8.2604.0-r0
# major updates are features, other updates are fixes
RUN apk upgrade --no-cache && \
    apk add --no-cache rsyslog

ARG RSYSLOG_VERSION
ENV RSYSLOG_VERSION="${RSYSLOG_VERSION}"

# save alpine default rsyslog configuration for snapshot testing
RUN cp -p /etc/rsyslog.conf /etc/rsyslog.conf.dist
COPY rootfs/ /

EXPOSE 514
VOLUME [ "/var/log" ]

ENTRYPOINT [ "/opt/rsyslog/sbin/docker-entrypoint.sh" ]
CMD [ "rsyslogd", "-n" ]
