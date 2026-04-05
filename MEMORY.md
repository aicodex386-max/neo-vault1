# MEMORY.md — Long-Term Memory

## Who I Am

- **Name:** Neo
- **What to call me:** Neo
- **Emoji:** 🤖 (pending final confirmation)

## Who I'm Helping

- **Name:** Ed
- **What to call him:** Ed
- **Operator style:** Gives clear operational directives, expects proactive execution
- **Skills installed:** tavily-search-pro (with API key configured), stealth-browser
- **Created:** ~/neo_vault as secure workspace
- **Operational rules:** See AGENTS.md "Operational Protocol (Ed's Rules)" section

## Key Context

- Tavily API key: configured in OpenClaw env (do not share)
- Stealth Browser: installed but flagged suspicious by ClawHub — use with caution
- Preferred approach: Tavily for search, stealth-browser as fallback
- Package install: from official Kali/Debian repos freely; ask before other sources
- Code from internet: always ask Ed before executing

## Kali Docker Setup

Ed has a Kali Linux Docker container for security testing tasks.

**Image:** `my-kali-tools`
**Container name:** `kali-session`
**Start (first time / new):** `sudo docker run -it --name kali-session my-kali-tools /bin/bash`
**Resume existing:** `sudo docker start -ai kali-session`

**Installed tool bundles:**
- `kali-tools-web` — sqlmap, nikto, burpsuite, gobuster, wpscan, etc.
- `kali-tools-passwords` — hydra, hashcat, john, medusa, etc.
- `kali-linux-headless` — full headless toolkit

**Usage:** Use this container for ALL security testing tasks (web app testing, password attacks, OSINT, etc.) whenever Ed asks. No need to re-explain.

## Tool Stack

- **Search:** tavily-search-pro (TAVILY_API_KEY set) → stealth-browser fallback
- **Stealth browser:** ~/workspace/skills/stealth-browser/ (DrissionPage, undetected-chromedriver installed)
- **Python packages:** installed via --break-system-packages (pip not root)
- **Security testing:** Kali Docker container (`kali-session`) — see Kali Docker Setup above

## Learned Lessons

- ClawHub rate-limits aggressively — use npx clawhub install instead of openclaw skills install when possible
- Stealth Browser slug is just "stealth-browser", not "mayuqi-crypto/stealth-browser"
- Tavily search works reliably; test with: `python3 skills/tavily-search-pro/lib/tavily_search.py search "test" --answer`
