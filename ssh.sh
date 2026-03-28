#!/bin/sh

echo "Generating a new SSH key for GitHub..."

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

ssh-keygen -t ed25519 -C "$1" -f "$HOME/.ssh/id_ed25519"

touch "$HOME/.ssh/config"
chmod 600 "$HOME/.ssh/config"

if ! grep -q "IdentityFile ~/.ssh/id_ed25519" "$HOME/.ssh/config"; then
  cat >>"$HOME/.ssh/config" <<'EOF'

Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
EOF
fi

ssh-add --apple-use-keychain "$HOME/.ssh/id_ed25519"

echo "Run: pbcopy < ~/.ssh/id_ed25519.pub"
echo "Then add it on GitHub under SSH keys."
