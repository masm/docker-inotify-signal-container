#!/bin/bash

if test $# -lt 3; then
    cat <<EOF
Need at least 3 arguments:
  - the container id,
  - the signal,
  - one or more files (or folders) to watch
EOF
    exit 1
fi

CONTAINER_ID="$1"
SIGNAL="$2"

if [[ "$SIGNAL" != SIG* ]]; then
    echo -e "Invalid signal name: $SIGNAL"
    exit 1
fi

# Leave just file and folder arguments
shift
shift

while inotifywait -e modify "$@"; do
    echo -e "POST /containers/$CONTAINER_ID/kill?signal=$SIGNAL HTTP/1.1\n" | ncat -U /var/run/docker.sock || exit 1
done
