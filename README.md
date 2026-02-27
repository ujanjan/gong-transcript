# gong-transcript

A [Claude Code](https://claude.ai/code) slash command that fetches and formats raw transcripts from the Gong API.

```
/gong-transcript 7782342007009289000
```

Claude will fetch the call, print a clean timestamped transcript, and give you a summary of speakers, topics, and action items.

---

## Requirements

- [Claude Code](https://claude.ai/code) installed
- A Gong account with API access
- Python 3 with `requests` (`pip install requests`)

---

## Install

```bash
git clone https://github.com/ujanjan/gong-transcript.git
cd gong-transcript
./install.sh
```

Then fill in your credentials:

```bash
# Open the file
open ~/.config/gong/credentials.json
```

```json
{
  "base_url": "https://us-XXXXX.api.gong.io",
  "access_key": "YOUR_ACCESS_KEY",
  "secret_key": "YOUR_SECRET_KEY"
}
```

Find your credentials in Gong under **Settings → Ecosystem → API**.

> **Note:** The `base_url` is tenant-specific. Using `api.gong.io` directly will return 404s.

---

## Usage

In any Claude Code session:

```
/gong-transcript <meeting_id>
```

The meeting ID is the numeric ID from the Gong call URL, e.g.:
`https://app.gong.io/call?id=7782342007009289000`

### Output

```
[00:04] John Smith: Thanks for joining today.
[00:09] Sarah Lee: Happy to be here.
[01:23] John Smith: Let's walk through the pricing.
...

Summary:
- John Smith: 62% of sentences
- Sarah Lee: 38% of sentences
Key topics: pricing, onboarding timeline, next steps
Action items: John to send proposal by Friday
```

---

## Credentials security

Your credentials are stored at `~/.config/gong/credentials.json` on your local machine only. The `.gitignore` in this repo excludes `credentials.json` so you won't accidentally commit them.

---

## How it works

The command is a Markdown file placed in `~/.claude/commands/`. When you run `/gong-transcript`, Claude Code reads the file, executes the embedded Python snippet via Bash to call the [Gong Transcript API](https://app.gong.io/settings/api-documentation#post-/v2/calls/transcript), then formats and summarizes the result.
