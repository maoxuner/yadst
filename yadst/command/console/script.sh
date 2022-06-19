#!/usr/bin/env bash

if [[ "$1" = "--help" ]]; then
    cat $(dirname $0)/help.txt
    exit 0
elif [[ $# -eq 0 ]]; then
    cat < /proc/self/fd/0 > "$YADST_PATH/console"
else
    for command in "$@"; do
        if [[ "$command" = "-" ]]; then
            cat < /proc/self/fd/0 > "$YADST_PATH/console"
        else
            echo "$command" > "$YADST_PATH/console"
        fi
    done
fi
