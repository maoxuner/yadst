#!/usr/bin/env bash

local_version() {
    cat $STEAMAPPDIR/steamapps/appmanifest_$STEAMAPPID.acf | clean_version
}

upstream_version() {
    rm -rf "$HOMEDIR/Steam/appcache/*"
    "$STEAMCMDDIR/steamcmd.sh" +runscript "$YADST_PATH/utils/version.txt" | clean_version
}

clean_version() {
    grep -Po -m 1 "\"buildid\"\s*\"(.*)\"" | grep -Po "\d*"
}

if [[ "$1" = "--help" ]]; then
    cat $(dirname $0)/help.txt
    exit 0
elif [[ $# -eq 0 ]]; then
    echo "Local version:    $(local_version)"
    echo "Upstream version: $(upstream_version)"
    exit 0
elif [[ $# -eq 1 ]]; then
    case "$1" in
        --local)
            local_version
            exit 0
            ;;

        --upstream)
            upstream_version
            exit 0
            ;;

        --check)
            version_local=$(local_version)
            version_upstream=$(upstream_version)

            if [[ "$version_local" -eq "$version_upstream" ]]; then
                echo "Version is up to date."
                exit 0
            else
                echo "Version is outdated."
                exit 1
            fi
            ;;
    esac
else
    cat $(dirname $0)/help.txt
    exit 1
fi
