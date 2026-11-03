# NextEdge Growth Intelligence

Scheduled trend and performance monitoring for YouTube, TikTok, Instagram, Facebook, X, Google Trends, Search Console, and Google Analytics.

## Setup

1. Create a **private** GitHub repository named `ai-blaster` under `nextedgeaccesssolutions-ra`.
2. Add the secrets listed in `.github/SECRETS.md`.
3. Push this folder to the repository.
4. Enable GitHub Actions. The workflow runs daily at 06:00 UTC and can also be started manually.

This starter is intentionally fail-safe: integrations without credentials are skipped and reported rather than logging secrets or publishing content.
