#!/bin/bash
# Neo Vault — One-Line Installer
# Run on a fresh machine. Sets up OpenClaw, Neo, and the full squad.
# Usage: curl -sL [raw-url] | bash
# Or download and run: bash install.sh

set -e

WORKSPACE_DIR="$HOME/.openclaw/workspace"
REPO_URL="https://github.com/aicodex386-max/neo-vault1.git"

echo "🔧 Installing OpenClaw..."
npm install -g openclaw

echo "📦 Cloning neo-vault..."
git clone "$REPO_URL" "$WORKSPACE_DIR"

echo "⚙️ Configuring git identity..."
cd "$WORKSPACE_DIR"
git config user.email "neo@neo.vault"
git config user.name "Neo"

echo "🎯 Setting workspace as default..."
openclaw config set agents.defaults.workspace "$WORKSPACE_DIR"

echo "🚀 Starting gateway..."
openclaw gateway restart

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Run: openclaw status"
echo "  2. If prompted, re-run: openclaw wizard"
echo "  3. Say hello to Neo!"
echo ""
echo "To push future backups:"
echo "  cd $WORKSPACE_DIR"
echo "  git remote set-url origin https://ghp_YOUR_TOKEN@github.com/aicodex386-max/neo-vault1.git"
echo "  git push"
