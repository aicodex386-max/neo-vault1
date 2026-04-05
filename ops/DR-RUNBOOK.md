# DR Runbook — Neo + OpenClaw Recovery

## What We're Backing Up

Everything lives in `~/.openclaw/workspace/` — it's a git repo.

```
~/.openclaw/workspace/
├── skills/
│   ├── trinity-recon/
│   ├── phantom-exploit/
│   ├── autonomous-loop/
│   ├── stealth-browser/
│   └── tavily-search-pro/
├── ops/
│   ├── scope/          ← operator-defined targets (check before pushing!)
│   ├── loop-state.json
│   └── loop-log.json
├── memory/
├── MEMORY.md
├── SOUL.md
├── IDENTITY.md
├── AGENTS.md
└── HEARTBEAT.md
```

**What's NOT backed up:**
- `~/.openclaw/openclaw.json` — recreate with `openclaw wizard`
- `~/.npm-global/` — OpenClaw npm package, reinstall with `npm install -g openclaw`
- Kali Docker image — rebuild from scratch, not critical

---

## One-Line Install (Recommended)

On a fresh machine, run:

```bash
bash <(curl -sL https://raw.githubusercontent.com/aicodex386-max/neo-vault1/main/install.sh)
```

This installs OpenClaw, clones the repo, configures git identity, sets the workspace, and starts the gateway.

---

## Manual New Machine Setup

```bash
# 1. Install OpenClaw
npm install -g openclaw

# 2. Clone your backup
git clone https://github.com/aicodex386-max/neo-vault1.git ~/.openclaw/workspace

# 3. Fix git identity (for this machine)
cd ~/.openclaw/workspace
git config user.email "neo@neo.vault"
git config user.name "Neo"

# 4. Point OpenClaw at workspace
openclaw config set agents.defaults.workspace ~/.openclaw/workspace

# 5. Start gateway
openclaw gateway restart

# 6. Set git remote with your PAT (so you can push backups)
git remote set-url origin https://ghp_YOUR_TOKEN@github.com/aicodex386-max/neo-vault1.git

# 7. Verify
openclaw status
```

Expected time: ~10-15 minutes.

---

## Daily Backup Habit

```bash
cd ~/.openclaw/workspace && git add -A && git commit -m "auto-backup $(date)" && git push
```

---

## What Gets Lost in a Crash

| Item | Lost? | How to Restore |
|------|-------|----------------|
| Trinity/Phoenix/Autonomous skills | ✅ Backed up | Clone repo |
| Memory, Soul, Identity, Agents files | ✅ Backed up | Clone repo |
| Loop state + logs | ✅ Backed up | Clone repo |
| Scope files | ⚠️ Optional | Recreate manually |
| OpenClaw config (openclaw.json) | ❌ Not in git | `openclaw wizard` |
| NPM packages (OpenClaw itself) | ❌ Not in git | `npm install -g openclaw` |
| Kali Docker | ❌ Not backed up | `apt install` or Docker pull |
| Telegram/WhatsApp/Signal tokens | ❌ Not in git | Re-authenticate channels |

---

## IMPORTANT — Scope Files

Check `ops/scope/` before pushing to git — those contain your authorized targets. You may want to keep scope files offline and recreate them manually on a new machine rather than pushing them to a public/private repo.

---

Questions? Ask Neo.
