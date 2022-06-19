FROM cm2network/steamcmd:root

RUN set -e; \
    sed -i 's/deb.debian.org/mirrors.tencent.com/g' /etc/apt/sources.list; \
    sed -i 's/security.debian.org/mirrors.tencent.com/g' /etc/apt/sources.list; \
    dpkg --add-architecture i386; \
    apt update; \
    apt install -y --no-install-recommends --no-install-suggests \
        libcurl4-gnutls-dev \
        libcurl4-gnutls-dev:i386; \
    rm -rf /var/lib/apt/lists/*

ENV STEAMAPPID 343050
ENV STEAMAPP dst
ENV STEAMAPPDIR "$HOMEDIR/$STEAMAPP-dedicated"

ENV YADST_PATH /opt/yadst
COPY yadst $YADST_PATH
RUN { \
        echo "@ShutdownOnFailedCommand 1"; \
        echo "@NoPromptForPassword 1"; \
        echo "force_install_dir $STEAMAPPDIR"; \
        echo "login anonymous"; \
        echo "app_update $STEAMAPPID validate"; \
        echo "quit"; \
    } > "$YADST_PATH/utils/setup.txt"; \
    { \
        echo "@ShutdownOnFailedCommand 1"; \
        echo "@NoPromptForPassword 1"; \
        echo "login anonymous"; \
        echo "app_info_update 1"; \
        echo "app_info_print $STEAMAPPID"; \
        echo "quit"; \
    } > "$YADST_PATH/utils/version.txt"
ENV PATH="$YADST_PATH/bin:$PATH"

ENV SERVER_ARCH amd64
ENV LANGUAGE en
ENV STORAGE_PATH /storage
ENV CLUSTER_NAME cluster
ENV SHARD_NAME shard
ENV SERVER_PORT 10999
ENV SHARD_BIND_IP 0.0.0.0
ENV ENCODE_USER_PATH true
ENV BACKUP_LOG_COUNT 0

VOLUME $STEAMAPPDIR
VOLUME $STORAGE_PATH

EXPOSE 10999/udp

ENTRYPOINT ["entrypoint"]
CMD ["yadst", "start"]
