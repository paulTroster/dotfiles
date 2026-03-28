#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${ZSH_EVAL_CONTEXT:-}" && "${ZSH_EVAL_CONTEXT}" == *:file ]]; then
  echo "Run this script with 'bash ./fresh.sh' or './fresh.sh', not 'source fresh.sh'."
  return 1
fi

if [[ -n "${BASH_SOURCE[0]:-}" && "${BASH_SOURCE[0]}" != "$0" ]]; then
  echo "Run this script with 'bash ./fresh.sh' or './fresh.sh', not 'source fresh.sh'."
  return 1
fi

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

# Refresh sudo once before cask installs so interactive prompts are expected.
sudo -v

# Install dependencies with verbose output so long-running cask downloads are visible
brew bundle --verbose --file ./Brewfile

# Bootstrap LazyVim starter config if Neovim has not been set up yet.
if [[ ! -d "$HOME/.config/nvim" ]]; then
  git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
  rm -rf "$HOME/.config/nvim/.git"
fi

# Symlink the Mackup config file to the home directory
ln -sfn ./.mackup.cfg "$HOME/.mackup.cfg"

# Set macOS preferences last in a separate shell so its sudo keepalive/background
# process does not leak into the current session.
bash ./.macos
