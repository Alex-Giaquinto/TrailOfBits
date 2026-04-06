#!/bin/bash
# Kandji Custom Script — Install Teleport Connect
# Run as: root | Remediation: enabled

set -euo pipefail

TELEPORT_VERSION="16.4.5"
DMG_URL="https://cdn.teleport.dev/teleport-connect-${TELEPORT_VERSION}.dmg"
DMG_PATH="/tmp/teleport-connect.dmg"
APP_NAME="Teleport Connect.app"
INSTALL_PATH="/Applications/${APP_NAME}"

if [[ -d "$INSTALL_PATH" ]]; then
  installed_version=$("$INSTALL_PATH/Contents/MacOS/Teleport Connect" --version 2>/dev/null | awk '{print $NF}' || echo "unknown")
  if [[ "$installed_version" == "$TELEPORT_VERSION" ]]; then
    echo "Teleport Connect ${TELEPORT_VERSION} is already installed."
    exit 0
  fi
  echo "Updating Teleport Connect ${installed_version} -> ${TELEPORT_VERSION}"
fi

echo "Downloading Teleport Connect ${TELEPORT_VERSION}..."
curl -fsSL -o "$DMG_PATH" "$DMG_URL"

MOUNT_POINT=$(hdiutil attach "$DMG_PATH" -nobrowse -quiet | awk 'END {print $NF}')

cp -R "${MOUNT_POINT}/${APP_NAME}" "$INSTALL_PATH"

hdiutil detach "$MOUNT_POINT" -quiet
rm -f "$DMG_PATH"

echo "Teleport Connect ${TELEPORT_VERSION} installed successfully."
