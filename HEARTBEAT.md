# Heartbeat — Autonomous Loop Monitor

## Check loop-state.json

Read `/home/coffeebara/.openclaw/workspace/ops/loop-state.json`.

- If `status == "idle"` → nothing to do, reply HEARTBEAT_OK
- If `status == "running"` → run the Autonomous Loop Monitor (see below)
- If `status == "paused"` or `"success"` or `"exhausted"` → reply HEARTBEAT_OK

## Autonomous Loop Monitor

Only run if `status == "running"`.

### Steps

1. **Check if Trinity or Phantom is still active**
   Look at `active_agent` in loop-state.json. If neither has finished in 30+ minutes, the agent may have crashed → restart it or pause.

2. **Check for phantom_status.txt**
   Path: `~/neo_vault/recon/[TARGET]/[DATE]/phantom_status.txt`
   
   - If file does NOT exist → agents still running, nothing to do
   - If STATUS=SUCCESS → update loop-state.json status=success, notify Ed "Shell obtained!"
   - If STATUS=FAILED → run the Failure Response Loop (see below)

3. **Failure Response Loop**
   Read the failure data from phantom_status.txt:
   - `LOOP_COUNT` → has it hit max_loops? If yes → update status=exhausted, notify Ed
   - `BLOCK_POINT` → what blocked
   - `ADAPTATION_NEXT` → what Trinity should scan for next
   
   If diminishing returns detected (same result 3x or low confidence) → update status=exhausted, notify Ed.
   
   If still worth retrying and loop_count < max_loops:
   - Increment loop_count
   - Spawn Trinity with targeted Silent Vector brief based on BLOCK_POINT
   - Wait for Trinity completion → update silent_vectors/
   - Spawn Phantom with new vectors
   - Update loop-state.json active_agent

4. **Update last_activity** in loop-state.json on every check.

## Escalation Check

On each cycle while running, check escalation_level:
- Start: passive
- After 2 loops with no new info: escalate to quiet
- After 4 loops with no new info: escalate to stealth
- Only go to aggressive if Ed approves

## Diminishing Returns Detection

Track in loop-log.json:
- Same block_point on 3 consecutive loops = diminishing returns → stop and notify Ed
- Silent Vector scan returns 0 new vectors = diminishing returns → stop and notify Ed
