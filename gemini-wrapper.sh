#!/bin/bash
ARGS=()
HAS_PROMPT=false
for arg in "$@"; do
    [ "$arg" = "--prompt" ] || [ "$arg" = "-p" ] && HAS_PROMPT=true
    [ "$arg" != "--sandbox" ] && ARGS+=("$arg")
done
if [ "$HAS_PROMPT" = false ] && [ "${#ARGS[@]}" -gt 0 ]; then
    LAST="${ARGS[-1]}"
    if [[ "$LAST" != -* ]]; then
        FRONT=("${ARGS[@]:0:${#ARGS[@]}-1}")
        exec gemini "${FRONT[@]}" -p "$LAST"
    fi
fi
exec gemini "${ARGS[@]}"
EOF

# Fix permissions for the Gemini authentication folder inside the container
docker exec -i appabcdo-paperclip-2b887e-server-1 chmod -R 777 /paperclip/.gemini
