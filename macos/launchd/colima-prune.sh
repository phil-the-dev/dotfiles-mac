#!/bin/bash
# Weekly cleanup for colima: prune unused docker images and build cache, then
# trim the VM disk so macOS reclaims the space. Run by launchd (see colima-prune.plist).

export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] colima-prune starting"

if ! colima status >/dev/null 2>&1; then
  echo "colima is not running, skipping"
  exit 0
fi

docker image prune -af --filter "until=168h"
docker builder prune -af --filter "until=168h"
colima ssh -- sudo fstrim -av
