#!/bin/bash
# Power2ADAPT Morning Brief -- Project action items
# Runs via launchd at 7am daily

CLAUDE="/Users/alistairtait/.npm/_npx/becf7b9e49303068/node_modules/.bin/claude"
LOG="$HOME/scripts/power2adapt_morning_brief.log"
unset CLAUDECODE
export PATH="/usr/local/bin:$PATH"

echo "$(date '+%Y-%m-%d %H:%M:%S') — Starting morning brief" >> "$LOG"

$CLAUDE --print --dangerously-skip-permissions --no-session-persistence -p "You are Alistair Tait's executive assistant for Power2ADAPT Pty Ltd. Today's date is $(date '+%A, %-d %B %Y').

Read all project README files in /Users/alistairtait/my-assistant/projects/ (skip node_modules and template subdirectories). Also read /Users/alistairtait/my-assistant/context/current-priorities.md.

Produce a concise morning brief in this format:

## Good morning, Alistair. Here's your briefing for $(date '+%A, %-d %B').

### Overdue / urgent
List any action items or key dates that are overdue or due today. If none, say 'Nothing overdue'.

### Action items this week
List the most important next steps across all active projects (skip completed or archived ones). Max 8 items. Format as: [Project name] -- action item.

### Watch list
Any projects where something is pending a response, a scheduled date, or an external dependency (e.g. waiting on a call, waiting on a client, waiting on a developer).

Keep it tight -- bullet points only, no lengthy explanations." >> "$LOG" 2>&1

echo "$(date '+%Y-%m-%d %H:%M:%S') — Morning brief complete" >> "$LOG"
