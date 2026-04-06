#!/bin/bash
# Kandji Custom Script — Activation Lock Check
# Run as: root | Remediation: enabled

set -euo pipefail

supervised=$(profiles status -type enrollment 2>/dev/null | grep -c "Supervised: Yes" || true)
fmm_enabled=$(defaults read /var/db/com.apple.findmymac.plist FMMEnabled 2>/dev/null || echo "0")

if [[ "$fmm_enabled" != "1" ]]; then
  echo "Activation Lock is not active."
  exit 0
fi

if [[ "$supervised" -eq 1 ]]; then
  echo "Activation Lock is active. Device is supervised — Kandji will send ClearActivationLockBypassCode at next check-in."
  exit 1
else
  echo "Activation Lock is active. Device is not supervised (manual enrollment) — user must sign out of iCloud to remove Activation Lock."
  exit 1
fi
