# LLM Video Analyzer

## Quick Start

```bash
./va.sh <url> <token> <model>
```

Takes images from `img/` directory (sorted by name) and sends them to an OpenAI-compatible API.

## Key Facts

- **Entry point**: `va.sh` - single bash script, no dependencies beyond `curl` and `base64`
- **Image folder**: `img/` - expects at least 2 images (`.jpeg`, `.jpg`, `.png`)
- **Images are sorted alphabetically** - naming matters (`frame1.jpeg`, `frame2.jpeg`, etc.)
- **All images sent** - not just 2; the API receives every image in the folder

## API Payload

Sends a user message with:
- A French text prompt about video analysis
- All images encoded as `data:image/jpeg;base64,...` URLs

## Common Mistakes to Avoid

- ❌ Forgetting to provide 3 arguments: `url`, `token`, `model`
- ❌ Having fewer than 2 images in `img/`
- ❌ Non-`.jpeg`/`.jpg`/`.png` files in `img/` (they're ignored by the glob)
