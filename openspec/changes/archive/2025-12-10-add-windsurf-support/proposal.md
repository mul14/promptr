# Change: Add Windsurf copy support

## Why
Users want to reuse their prompts in Windsurf without manual copying. Adding a managed target keeps Windsurf in sync alongside other agents.

## What Changes
- Support Windsurf as a copy-based agent writing to `~/.codeium/windsurf/global_workflows` using the configured/stored prefix (default `promptr`) with a trailing dash for filenames.
- Include Windsurf in link/update/unlink flows with the same link-state tracking and safety rules as existing copy targets.
- Update help/docs to list Windsurf and its path.

## Impact
- Affected specs: promptr-cli
- Affected code: bin/promptr, README/help text
