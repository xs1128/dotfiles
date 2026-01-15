#!/bin/bash

set -e

install_dmg() {
  local app="$1" url="$2" bundle="$3"
  local dmg="$HOME/Downloads/${app}.dmg"
  local vol="/Volumes/$app"

  mdfind "kMDItemCFBundleIdentifier == '$bundle'" | grep -q . && {
    echo "✓ $app"
    return
  }

  curl -L -o "$dmg" "$url"
  hdiutil attach "$dmg" -mountpoint "$vol" -nobrowse
  cp -R "$vol/$app.app" /Applications/
  hdiutil detach "$vol"
  rm -f "$dmg"
}

# clipy clipboard
install_dmg "Clipy" \
  "https://github.com/Clipy/Clipy/releases/download/1.2.1/Clipy_1.2.1.dmg" \
  "com.clipy-app.Clipy"

