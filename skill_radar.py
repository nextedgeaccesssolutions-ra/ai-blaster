import json
import os
import re
from datetime import datetime, timezone
from pathlib import Path

import requests

QUERY = 'filename:SKILL.md (seo OR social OR marketing OR analytics OR trends)'
API = 'https://api.github.com/search/code'
headers = {'Accept': 'application/vnd.github+json'}
if os.getenv('GITHUB_TOKEN'):
    headers['Authorization'] = f"Bearer {os.environ['GITHUB_TOKEN']}"

response = requests.get(API, params={'q': QUERY, 'per_page': 30}, headers=headers, timeout=30)
items = response.json().get('items', []) if response.ok else []

results = []
for item in items:
    path = item.get('path', '')
    repo = item.get('repository', {})
    if not path.lower().endswith('skill.md') or not repo.get('full_name'):
        continue
    results.append({
        'repository': repo['full_name'],
        'path': path,
        'html_url': item.get('html_url'),
        'raw_url': f"https://raw.githubusercontent.com/{repo['full_name']}/HEAD/{path}",
        'review_status': 'candidate-only',
        'reason': 'Discovered by public GitHub search; inspect license, provenance, and instructions before adaptation.',
    })

report = {
    'generated_at': datetime.now(timezone.utc).isoformat(),
    'query': QUERY,
    'candidate_count': len(results),
    'candidates': results,
    'request_status': response.status_code,
    'request_note': 'Add GITHUB_TOKEN locally for code search.' if response.status_code == 401 else '',
    'policy': 'No remote skill is cloned, executed, or merged automatically.',
}

out = Path('reports')
out.mkdir(exist_ok=True)
(out / 'skill-radar.json').write_text(json.dumps(report, indent=2) + '\n', encoding='utf-8')
print(json.dumps(report, indent=2))
