FROM alpine:3.24.2@sha256:31b6477333eb8257db9e5d7c3a7264fd0467928756f0bbcc27d35bea5d28cdbd

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
