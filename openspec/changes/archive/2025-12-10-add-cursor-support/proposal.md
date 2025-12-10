# Change: Add Cursor agent support

## Why
Users want to link prompts into Cursor so they can reuse the same prompt set across editors without manual copying.

## What Changes
- Add Cursor as a supported agent with symlink-based linking at `~/.cursor/commands/<prefix>`, using the configured/stored prefix (default `promptr`) without a trailing dash.
- Extend link/unlink flows, stored link state, and help text to include Cursor alongside existing agents.
- Keep copy-based agents and prefix handling unchanged.

## Impact
- Affected specs: promptr-cli
- Affected code: bin/promptr, README/help text (command descriptions)
