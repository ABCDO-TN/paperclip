#!/bin/bash

# 1. Générer le jeton d'accès dynamiquement via le compte Google connecté
echo "Obtention du token d'accès Google..."
OAUTH_TOKEN=$(gcloud auth print-access-token 2>/dev/null)

if [ -z "$OAUTH_TOKEN" ]; then
  echo "Erreur : Impossible d'obtenir le token. Êtes-vous connecté avec 'gcloud auth application-default login' ?"
  exit 1
fi

# 2. Exporter le token comme clé API / Jeton pour que la commande en dessous l'utilise
export GEMINI_API_KEY="$OAUTH_TOKEN"
export GOOGLE_ACCESS_TOKEN="$OAUTH_TOKEN"

# 3. Logique originale du wrapper
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