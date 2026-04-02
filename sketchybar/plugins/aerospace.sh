#!/bin/bash

AEROSPACE_BIN="/opt/homebrew/bin/aerospace"
SKETCHYBAR_BIN="/opt/homebrew/bin/sketchybar"

# Get the current focused workspace from AeroSpace
FOCUSED_WORKSPACE="$("$AEROSPACE_BIN" list-workspaces --focused)"

# Update all workspace items
for i in {1..9}; do
  if [ "$i" = "$FOCUSED_WORKSPACE" ]; then
    "$SKETCHYBAR_BIN" --set "space.$i" background.drawing=on
  else
    "$SKETCHYBAR_BIN" --set "space.$i" background.drawing=off
  fi
done
