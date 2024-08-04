#!/bin/bash

# Enable strict error handling
set -euo pipefail

# Path to the JSON file that contains the list of extensions
EXTENSIONS_JSON_PATH="$HOME/.vscode-extensions.json"

# Function to log messages
log() {
  echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

# Check if the JSON file exists
if [[ ! -f "$EXTENSIONS_JSON_PATH" ]]; then
  log "Error: JSON file '$EXTENSIONS_JSON_PATH' not found!"
  exit 1
fi

# Determine which command to use (code-server or code)
if command -v code &>/dev/null; then
  CODE_CMD="code"
else
  CODE_CMD="code-server"
fi

# Fetch the list of extensions from the JSON file using jq
log "Fetching list of extensions from JSON file..."
NEW_EXTENSIONS=$(jq -r '.[]' "$EXTENSIONS_JSON_PATH")

# Fetch the list of installed extensions
log "Fetching list of installed extensions..."
INSTALLED_EXTENSIONS=$($CODE_CMD --list-extensions)

# Remove extensions that are not in the provided list
log "Removing extensions that are no longer needed..."
for extension in $INSTALLED_EXTENSIONS; do
  if ! echo "$NEW_EXTENSIONS" | grep -q "$extension"; then
    $CODE_CMD --uninstall-extension "$extension" --force
  fi
done

# Install new extensions that are missing
log "Installing missing extensions..."
for extension in $NEW_EXTENSIONS; do
  if ! echo "$INSTALLED_EXTENSIONS" | grep -q "$extension"; then
    $CODE_CMD --install-extension "$extension" --force
  fi
done

log "Extension synchronization complete."
