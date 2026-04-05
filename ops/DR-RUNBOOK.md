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

## Setting Up Remote Backup

### Option 1: GitHub Private Repo

```bash
# On your local machine (already has the repo)
cd ~/.openclaw/workspace
git remote add origin https://github.com/YOUR_USERNAME/neo-vault.git
git branch -M main
git push -u origin main

# Later — on a new machine
git clone https://github.com/YOUR_USERNAME/neo-vault.git ~/.openclaw/workspace
```

### Option 2: GitLab Private Repo

```bash
cd ~/.openclaw/workspace
git remote add origin https://gitlab.com/YOUR_USERNAME/neo-vault.git
git branch -M main
git push -u origin main
```

### IMPORTANT — Before Pushing

Check `ops/scope/` — those files contain your authorized targets. You may want to:
- Keep scope files offline (don't push to git)
- Or add `ops/scope/` to `.gitignore`

---

## New Machine Setup (Complete DR)

Run these commands in order:

```bash
# 1. Install OpenClaw
npm install -g openclaw

# 2. Clone your backup
git clone https://github.com/YOUR_USERNAME/neo-vault.git ~/.openclaw/workspace

# 3. Set workspace as default
openclaw config set agents.defaults.workspace ~/.openclaw/workspace

# 4. Re-run the wizard (creates new openclaw.json)
openclaw wizard

# 5. Fix git identity (for this machine)
cd ~/.openclaw/workspace
git config user.email "neo@neo.vault"
git config user.name "Neo"

# 6. Verify skills loaded
openclaw skills list

# 7. Recreate scope directory
mkdir -p ~/.openclaw/workspace/ops/scope

# 8. Start the gateway
openclaw gateway start
```

Expected time: ~10-15 minutes.

---

## What Gets Lost in a Crash

| Item | Lost? | How to Restore |
|------|-------|----------------|
| Trinity/Phoenix/Autonomous skills | ✅ Backed up in git | Clone repo |
| Memory, Soul, Identity, Agents files | ✅ Backed up | Clone repo |
| Loop state + logs | ✅ Backed up | Clone repo |
| Scope files | ⚠️ Optional | Recreate manually |
| OpenClaw config (openclaw.json) | ❌ Not in git | `openclaw wizard` |
| NPM packages (OpenClaw itself) | ❌ Not in git | `npm install -g openclaw` |
| Kali Docker | ❌ Not backed up | `apt install` or Docker pull |
| Telegram/WhatsApp/Signal tokens | ❌ Not in git | Re-authenticate channels |

---

## Recommended: Daily Backup Habit

```bash
# Quick push (run end of each session)
cd ~/.openclaw/workspace && git add -A && git commit -m "auto-backup $(date)" && git push
```

Or I can set up a cron job to auto-push daily.

---

## Heartbeat State

Heartbeat state is in `memory/heartbeat-state.json`. It's also in the git repo, so backed up.

---

Questions? Ask Neo.
