# Change: Add Codex prompt copying with prefixed filenames

## Why
Codex needs access to the prompt collection without using symlinks. Adding a copy target keeps Codex in sync while avoiding unsafe links.

## What Changes
- Add a Codex target that copies prompt files into `~/.codex/prompts` using a `promptr-` filename prefix.
- Extend `link all` to include the Codex copy target alongside existing agents.
- Track Codex link state and refresh copies during updates and unlink operations.

## Impact
- Affected specs: `promptr-cli`
- Affected code: `bin/promptr`, prompt copy/link helpers, help text, and docs
