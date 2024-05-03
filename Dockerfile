FROM ubuntu:24.04

RUN sed -i 's/ports.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list.d/ubuntu.sources

RUN set -e; \
    apt-get update; \
    apt-get install \
        -o Dpkg::Options::="--force-confdef" \
        -o Dpkg::Options::="--force-confnew" \
        -y --no-install-recommends \
        ca-certificates \
        libstdc++6 libgcc-s1 libcurl4-gnutls-dev; \
    rm -rf /var/lib/apt/lists/*
