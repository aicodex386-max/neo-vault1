# Neo Vault

Backup and setup for Neo — AI assistant, Trinity (recon), and Phantom (exploitation).

---

## What is this?

This repo contains everything needed to restore Neo and the full red team squad on a fresh machine.

**What's included:**
- Neo's skills (Trinity, Phantom, autonomous-loop)
- Memory, SOUL, IDENTITY, AGENTS files
- Loop state, logs, DR runbook
- HEARTBEAT configuration
- All operational files

---

## Quick Start — New Machine

One command to set everything up:

```bash
bash <(curl -sL https://raw.githubusercontent.com/aicodex386-max/neo-vault1/main/install.sh)
```

That's it. OpenClaw installs, Neo and the squad clone down, workspace is configured, gateway starts.

---

## Manual Setup

```bash
# 1. Install OpenClaw
npm install -g openclaw

# 2. Clone your backup
git clone https://github.com/aicodex386-max/neo-vault1.git ~/.openclaw/workspace

# 3. Configure git identity
cd ~/.openclaw/workspace
git config user.email "neo@neo.vault"
git config user.name "Neo"

# 4. Point OpenClaw at the workspace
openclaw config set agents.defaults.workspace ~/.openclaw/workspace

# 5. Start the gateway
openclaw gateway start

# 6. Verify
openclaw status
```

---

## What Gets Restored ✅

- Skills (Trinity, Phantom, autonomous-loop)
- Memory, SOUL, IDENTITY, AGENTS files
- Loop state, logs, DR runbook
- HEARTBEAT configuration

## What Needs Reinstalling ❌

- OpenClaw itself — `npm install -g openclaw`
- NPM packages — handled by the install script
- Gateway service — `openclaw gateway start`
- Git credentials — set your PAT in the remote URL to push backups

---

## Daily Backup

```bash
cd ~/.openclaw/workspace && git add -A && git commit -m "auto-backup $(date)" && git push
```

---

## Scope Files

`ops/scope/` contains your authorized targets. Keep these offline or handle separately — they may contain sensitive operational data.

---

## Skills

| Agent | Role |
|-------|------|
| **Trinity** 🔍 | Reconnaissance + Silent Vector discovery |
| **Phantom** 💥 | Weaponization + Exploitation + Heuristic evasion |
| **Neo** 🤖 | Autonomous coordinator + loop monitor |

---

## Docs

- [DR Runbook](ops/DR-RUNBOOK.md) — full disaster recovery guide
- [Install Script](install.sh) — one-line installer source
