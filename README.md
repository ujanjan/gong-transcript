# gong-transcript

A [Claude Code](https://claude.ai/code) slash command that fetches a Gong call transcript and saves it as a markdown file.

```
/gong-transcript 7782342007009289000
```

The meeting ID is the numeric ID from the Gong call URL:
`https://app.gong.io/call?id=7782342007009289000`

The transcript is saved to `~/Downloads/gong-<call_id>.md`.

---

## Requirements

- [Claude Code](https://claude.ai/code)
- A Gong account with API access
- Python 3 (stdlib only, no pip install needed)

---

## Install

```bash
git clone https://github.com/ujanjan/gong-transcript.git
cd gong-transcript
./install.sh
```

The script will prompt for your Gong API credentials and save them to `~/.config/gong/credentials.json`.

> Find your credentials in Gong under **Settings → Ecosystem → API**. The base URL is tenant-specific (e.g. `https://us-12345.api.gong.io`) — using `api.gong.io` directly won't work.
