# Ai Blaster agent instructions

Use the reusable skills in `.agents/skills/`. Keep provider-specific behavior in the adapter files and keep the actual automation logic in `monitor.py` and `.github/workflows/`.

Never commit API keys, OAuth tokens, service-account JSON, or `.env` files.
