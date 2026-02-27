#!/usr/bin/env bash
set -e

COMMANDS_DIR="$HOME/.claude/commands"
CREDS_DIR="$HOME/.config/gong"
CREDS_FILE="$CREDS_DIR/credentials.json"

echo "Installing gong-transcript Claude Code command..."

# Install the slash command
mkdir -p "$COMMANDS_DIR"
cp commands/gong-transcript.md "$COMMANDS_DIR/gong-transcript.md"
echo "  ✓ Command installed to $COMMANDS_DIR/gong-transcript.md"

# Set up credentials file if it doesn't exist
if [ ! -f "$CREDS_FILE" ]; then
  mkdir -p "$CREDS_DIR"
  cp credentials.example.json "$CREDS_FILE"
  echo "  ✓ Credentials template created at $CREDS_FILE"
  echo ""
  echo "  Next: fill in your Gong API credentials:"
  echo "    $CREDS_FILE"
  echo ""
  echo "  Find them in Gong → Settings → Ecosystem → API"
else
  echo "  - Credentials file already exists at $CREDS_FILE, skipping."
fi

# Check for requests library
if ! python3 -c "import requests" 2>/dev/null; then
  echo ""
  echo "  Note: 'requests' Python package not found."
  echo "  Install it with: pip install requests"
fi

echo ""
echo "Done. Use it with:"
echo "  /gong-transcript <meeting_id>"
