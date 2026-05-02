# LLM Video Analyzer

Analyse de vidéos en envoyant toutes les images d'un dossier à une API LLM compatible OpenAI.

## Prérequis

- `curl`
- `base64`
- Dossier `img/` contenant au moins 2 images (`.jpeg`, `.jpg`, `.png`)

## Utilisation

```bash
./va.sh <url> <token> <model>
```

### Paramètres

- **url** : URL de l'API (ex: `https://api.openaicompatible.com/v1/chat/completions`)
- **token** : Jeton d'authentification
- **model** : Modèle LLM à utiliser (ex: `gemma`)

## Exemple

```bash
./va.sh https://api.openaicompatible.com/v1/chat/completions sk-xxxxx my-model
```

Le script envoie automatiquement toutes les images du dossier `img/` triées par nom.
