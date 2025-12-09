# Change: Add configurable prompt filename prefix

## Why
Current link/update flows hardcode the `promptr-` prefix, so users cannot align copied filenames with their own naming conventions.

## What Changes
- Introduce an environment-configurable prefix (`PROMPTR_PREFIX`) that defaults to `promptr-` for copied prompt files.
- Apply the prefix consistently across link, update, and unlink flows for agents that rely on prefixed filenames (Droid, Copilot, Codex).
- Document the default and override behavior in CLI expectations.

## Impact
- Affected specs: promptr-cli
- Affected code: bin/promptr (prefix handling in link/update/unlink), README.md (documented behavior)
