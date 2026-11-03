import json
import os
from datetime import datetime, timezone
from pathlib import Path

services = {
    "youtube": bool(os.getenv("YOUTUBE_API_KEY")),
    "tiktok": bool(os.getenv("TIKTOK_ACCESS_TOKEN")),
    "instagram": bool(os.getenv("META_ACCESS_TOKEN")),
    "facebook": bool(os.getenv("META_ACCESS_TOKEN")),
    "x": bool(os.getenv("X_BEARER_TOKEN")),
    "google_trends": bool(os.getenv("GOOGLE_SERVICE_ACCOUNT_JSON")),
    "search_console": bool(os.getenv("GOOGLE_SERVICE_ACCOUNT_JSON") and os.getenv("SEARCH_CONSOLE_SITE_URL")),
    "analytics": bool(os.getenv("GOOGLE_SERVICE_ACCOUNT_JSON") and os.getenv("GA4_PROPERTY_ID")),
}

report = {
    "generated_at": datetime.now(timezone.utc).isoformat(),
    "status": "partial" if not all(services.values()) else "ready",
    "services": services,
    "note": "Connect credentials in GitHub Actions secrets to enable each source.",
}

out = Path("reports")
out.mkdir(exist_ok=True)
(out / "latest.json").write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
print(json.dumps(report, indent=2))
