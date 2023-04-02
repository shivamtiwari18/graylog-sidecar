FROM debian

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends curl ca-certificates; \
    curl -Lo graylog-sidecar.deb https://github.com/Graylog2/collector-sidecar/releases/download/1.4.0/graylog-sidecar_1.4.0-1_amd64.deb; \
    curl -Lo filebeat.deb https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.6.2-amd64.deb; \
    dpkg -i graylog-sidecar.deb filebeat.deb; \
    rm graylog-sidecar.deb filebeat.deb; \
    apt-get autoremove --purge -y curl; \
    rm -rf /var/lib/apt/lists/*

ADD sidecar.yml /etc/graylog/sidecar/sidecar.yml

CMD /usr/bin/graylog-sidecar -c /etc/graylog/sidecar/sidecar.yml