#!/bin/bash

AEROSPACE_BIN="/opt/homebrew/bin/aerospace"

# Switch to the workspace
"$AEROSPACE_BIN" workspace "$1"

# Update sketchybar highlighting directly
"$HOME/.config/sketchybar/plugins/aerospace.sh"
