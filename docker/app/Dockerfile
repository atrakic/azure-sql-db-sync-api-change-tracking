FROM ubuntu
RUN set -x \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y curl ca-certificates jq \
    && apt-get remove --purge --auto-remove -y && rm -rf /var/lib/apt/lists/*

COPY --chmod=0755 entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]
