FROM alpine:3.24.4@sha256:93b41ef40b1677fce8fcc64ff4af09daddfacf5040afde618bc46c1e2d1cc7d4

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
