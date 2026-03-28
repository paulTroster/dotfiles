#!/usr/bin/env bash

echo "Setting up your Mac..."

# Check if Xcode Command Line Tools are installed
if ! xcode-select -p >/dev/null 2>&1; then
  echo "Xcode Command Line Tools not found. Installing..."
  xcode-select --install
else
  echo "Xcode Command Line Tools already installed."
fi

# Check for Homebrew and install if we don't have it
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>"$HOME/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Create symlinks
rm -rf "$HOME/.zshrc"
ln -sw "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"

mkdir -p "$HOME/.config"
rm -rf "$HOME/.config/ghostty"
ln -sw "$HOME/.dotfiles/ghostty" "$HOME/.config/ghostty"

# Update Homebrew recipes
brew update

# Install dependencies
brew bundle --file ./Brewfile

# Symlink the Mackup config file to the home directory
ln -sfn ./.mackup.cfg "$HOME/.mackup.cfg"

# Set macOS preferences last in a separate shell so its sudo keepalive/background
# process does not leak into the current session.
bash ./.macos
