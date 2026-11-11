FROM alpine:3.24.4@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf

# rsyslog 8.2608.0-r0
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
