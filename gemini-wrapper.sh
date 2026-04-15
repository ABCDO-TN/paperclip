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
