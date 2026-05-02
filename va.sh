#!/bin/bash

if [ $# -lt 3 ]; then
  echo "Usage: $0 <url> <token> <model>"
  exit 1
fi

URL="$1"
TOKEN="$2"
MODEL="$3"

# 1. Récupérer toutes les images du dossier img dans l'ordre
IMAGES=($(ls -1 img/*.jpeg img/*.jpg img/*.png 2>/dev/null | sort))

if [ ${#IMAGES[@]} -lt 2 ]; then
  echo "Erreur: Au moins 2 images sont requises dans le dossier img/"
  exit 1
fi

# 2. Construire le content array en JSON
CONTENT_JSON=""
FIRST=true
for img in "${IMAGES[@]}"; do
  B64=$(base64 -w 0 "$img" 2>/dev/null)
  if [ -z "$B64" ]; then
    echo "Erreur: Impossible de lire l'image $img"
    exit 1
  fi
  if [ "$FIRST" = true ]; then
    FIRST=false
    CONTENT_JSON="[{\"type\":\"text\",\"text\":\"Analyse ces frames d'une vidéo. Quelle est la progression de l'action?\"}"
  fi
  CONTENT_JSON="$CONTENT_JSON,{\"type\":\"image_url\",\"image_url\":{\"url\":\"data:image/jpeg;base64,$B64\"}}"
done
CONTENT_JSON="$CONTENT_JSON]"

# 3. Créer le payload JSON dans un fichier temporaire
PAYLOAD=$(mktemp)
cat > "$PAYLOAD" << EOJSON
{
  "model": "$MODEL",
  "messages": [
    {
      "role": "user",
      "content": $CONTENT_JSON
    }
  ],
  "temperature": 0,
  "max_tokens": 2048
}
EOJSON

# 4. Envoyer la requête à ton LiteLLM
curl -sL --request POST \
  --url "$URL" \
  --header "Authorization: Bearer $TOKEN" \
  --header 'Content-Type: application/json' \
  --data @"$PAYLOAD"

# 5. Nettoyer
rm -f "$PAYLOAD"
