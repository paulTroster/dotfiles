#!/bin/sh

SKETCHYBAR_BIN="/opt/homebrew/bin/sketchybar"

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

"$SKETCHYBAR_BIN" --set "$NAME" background.drawing="$SELECTED"
