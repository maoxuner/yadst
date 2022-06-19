#!/usr/bin/env bash

if [[ "$1" = "--help" ]]; then
    cat $(dirname $0)/help.txt
    exit 0
else
    while [[ "$#" -gt 0 ]]
    do
        case "$1" in
            --update)
                yadst update
                ;;
        esac
        shift
    done
fi

sleep infinity > "$YADST_PATH/console" &

exec dst-server \
    -skip_update_server_mods \
    -backup_log_count "$BACKUP_LOG_COUNT"
