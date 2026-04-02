#!/bin/sh

SKETCHYBAR_BIN="/opt/homebrew/bin/sketchybar"

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

"$SKETCHYBAR_BIN" --set "$NAME" label="$(date '+%d/%m %H:%M')"
