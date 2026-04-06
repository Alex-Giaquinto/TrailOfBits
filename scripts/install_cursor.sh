#!/bin/bash
# Kandji Custom Script — Install Cursor and configure privacy settings
# Run as: root | Remediation: enabled

set -euo pipefail

APP_NAME="Cursor.app"
INSTALL_PATH="/Applications/${APP_NAME}"
ARCH=$(uname -m)

if [[ "$ARCH" == "arm64" ]]; then
  DMG_URL="https://downloader.cursor.sh/mac/dmg/arm64"
else
  DMG_URL="https://downloader.cursor.sh/mac/dmg/x64"
fi

DMG_PATH="/tmp/cursor.dmg"

if [[ ! -d "$INSTALL_PATH" ]]; then
  echo "Downloading Cursor..."
  curl -fsSL -o "$DMG_PATH" "$DMG_URL"

  MOUNT_POINT=$(hdiutil attach "$DMG_PATH" -nobrowse -quiet | awk 'END {print $NF}')
  cp -R "${MOUNT_POINT}/${APP_NAME}" "$INSTALL_PATH"
  hdiutil detach "$MOUNT_POINT" -quiet
  rm -f "$DMG_PATH"

  echo "Cursor installed."
else
  echo "Cursor already installed, skipping install."
fi

# Configure privacy settings for the logged-in user
LOGGED_IN_USER=$(stat -f "%Su" /dev/console)
USER_HOME=$(dscl . -read "/Users/${LOGGED_IN_USER}" NFSHomeDirectory | awk '{print $2}')
SETTINGS_DIR="${USER_HOME}/Library/Application Support/Cursor/User"
SETTINGS_FILE="${SETTINGS_DIR}/settings.json"

mkdir -p "$SETTINGS_DIR"

if [[ ! -f "$SETTINGS_FILE" ]]; then
  echo "{}" > "$SETTINGS_FILE"
fi

UPDATED=$(python3 - "$SETTINGS_FILE" <<'PYTHON'
import json, sys

path = sys.argv[1]
with open(path, "r") as f:
  settings = json.load(f)

settings["telemetry.telemetryLevel"]        = "off"
settings["cursor.privacy.privacyMode"]      = "enabled"
settings["cursor.general.enableAutoImport"] = False

with open(path, "w") as f:
  json.dump(settings, f, indent=2)

print("updated")
PYTHON
)

chown "${LOGGED_IN_USER}" "$SETTINGS_FILE"

echo "Cursor privacy settings configured for ${LOGGED_IN_USER}."
