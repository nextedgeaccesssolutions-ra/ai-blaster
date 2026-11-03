# Required GitHub Actions secrets

Add only the credentials for services you use. Never commit these values.

- `YOUTUBE_API_KEY`
- `TIKTOK_ACCESS_TOKEN`
- `META_ACCESS_TOKEN` (Instagram and Facebook)
- `X_BEARER_TOKEN`
- `GOOGLE_SERVICE_ACCOUNT_JSON` (Google Trends, Search Console, and Analytics)
- `SEARCH_CONSOLE_SITE_URL`
- `GA4_PROPERTY_ID`

The workflow reads these as environment variables. Publishing, replies, and account changes are not enabled by this monitor.
