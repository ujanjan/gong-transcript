# Gong Transcript Fetcher

Fetch and display the raw transcript for a Gong call.

## Usage
/gong-transcript <meeting_id>

## Steps

1. Read Gong credentials from `~/.config/gong/credentials.json`:
   - `base_url`: e.g. `https://us-12345.api.gong.io`
   - `access_key`
   - `secret_key`

2. Run the following Python snippet via Bash to fetch the transcript:

```python
import base64, json, sys, os
from urllib.request import urlopen, Request
from urllib.error import HTTPError

creds_path = os.path.expanduser('~/.config/gong/credentials.json')

try:
    with open(creds_path) as f:
        creds = json.load(f)
except FileNotFoundError:
    print(f"ERROR: Credentials file not found at {creds_path}")
    print("Run the install script and fill in your Gong API credentials.")
    sys.exit(1)

encoded = base64.b64encode(f"{creds['access_key']}:{creds['secret_key']}".encode()).decode()
body = json.dumps({"filter": {"callIds": ["$ARGUMENTS"]}}).encode()

req = Request(
    f"{creds['base_url']}/v2/calls/transcript",
    data=body,
    headers={
        "Authorization": f"Basic {encoded}",
        "Content-Type": "application/json"
    }
)

try:
    with urlopen(req) as resp:
        print(json.dumps(json.loads(resp.read()), indent=2))
except HTTPError as e:
    print(f"ERROR {e.code}: {e.read().decode()}")
    sys.exit(1)
```

3. Format the response as a clean, readable transcript:
   - Convert `start` milliseconds to `MM:SS` format
   - Sort all sentences by timestamp (ascending)
   - Print each line as: `[MM:SS] SpeakerName: sentence text`

4. After printing the transcript, provide a brief summary:
   - Who spoke and roughly how much (% of sentences)
   - Key topics or themes discussed
   - Any action items or next steps mentioned

5. If the API returns an error or the call is not found, surface the error clearly with the HTTP status code and response body.
