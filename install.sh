#!/usr/bin/env bash
set -e

COMMANDS_DIR="$HOME/.claude/commands"
CREDS_DIR="$HOME/.config/gong"
CREDS_FILE="$CREDS_DIR/credentials.json"

echo "Installing gong-transcript Claude Code command..."
echo ""

# Install the slash command
mkdir -p "$COMMANDS_DIR"
cp commands/gong-transcript.md "$COMMANDS_DIR/gong-transcript.md"
echo "  ✓ Command installed to $COMMANDS_DIR/gong-transcript.md"
echo ""

# Prompt for credentials
prompt_credentials() {
  echo "Enter your Gong API credentials."
  echo "Find them in Gong → Settings → Ecosystem → API"
  echo ""

  read -p "  Base URL (e.g. https://us-12345.api.gong.io): " base_url
  read -p "  Access Key: " access_key
  read -s -p "  Secret Key: " secret_key
  echo ""

  mkdir -p "$CREDS_DIR"
  cat > "$CREDS_FILE" <<EOF
{
  "base_url": "$base_url",
  "access_key": "$access_key",
  "secret_key": "$secret_key"
}
EOF
  echo "  ✓ Credentials saved to $CREDS_FILE"
}

if [ -f "$CREDS_FILE" ]; then
  echo "  Credentials file already exists at $CREDS_FILE"
  read -p "  Overwrite with new credentials? [y/N] " confirm
  echo ""
  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    prompt_credentials
  else
    echo "  Keeping existing credentials."
  fi
else
  prompt_credentials
fi

echo ""
echo "Done. Use it with:"
echo "  /gong-transcript <meeting_id>"
