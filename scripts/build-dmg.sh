#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
sh scripts/build-native.sh
STAGE=$(mktemp -d)
trap 'rm -rf "$STAGE"' EXIT
ditto build/Boltbar.app "$STAGE/Boltbar.app"
ln -s /Applications "$STAGE/Applications"
hdiutil create -volname Boltbar -srcfolder "$STAGE" -fs HFS+ -format UDZO build/Boltbar.dmg
printf 'DMG: %s/build/Boltbar.dmg\n' "$PWD"
