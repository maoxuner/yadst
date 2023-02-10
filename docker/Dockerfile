FROM ubuntu:22.04

RUN set -e; \
    sed -i 's/archive.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list; \
    sed -i 's/security.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list

RUN set -e; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        libstdc++6 libgcc-s1 libcurl4-gnutls-dev; \
    rm -rf /var/lib/apt/lists/*
