#!/usr/bin/env bash

if [[ "$1" = "--help" ]]; then
    cat $(dirname $0)/help.txt
    exit 0
elif [[ $# -eq 0 ]]; then
    exec "$STEAMCMDDIR/steamcmd.sh" +runscript "$YADST_PATH/utils/setup.txt"
    dst-server -only_update_server_mods
fi
