# Change: Add Claude agent link target

## Why
Users want to link their prompt collection into Claude so they can reuse the same prompts across supported agents.

## What Changes
- Add a Claude agent target (`promptr link claude`) that symlinks to `~/.claude/commands/promptr` with existing safety checks and `--force` behavior
- Include Claude in the `link all` flow and CLI help text

## Impact
- Affected specs: promptr-cli
- Affected code: bin/promptr, README.md
