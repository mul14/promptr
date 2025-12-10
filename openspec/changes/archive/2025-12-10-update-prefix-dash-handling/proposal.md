# Change: Update prefix dash handling for copies vs symlinks

## Why
The stored `PROMPTR_PREFIX` currently includes a trailing dash (`promptr-`), which bleeds into contexts that should not carry a dash and makes the persisted value awkward to reuse. We need the prefix to be stored without the dash while still producing dashed filenames for copied prompts.

## What Changes
- Store and default `PROMPTR_PREFIX` as `promptr` (no trailing dash) while appending a dash only when building copied prompt filenames.
- Use the configured/stored prefix (default `promptr`) for symlink names instead of a hard-coded `promptr`, keeping it undashed.
- Update CLI behavior, persistence, and messaging so copy workflows still produce `promptr-<name>` while the configurable prefix value remains undashed.

## Impact
- Affected specs: promptr-cli
- Affected code: bin/promptr, setup.sh, README/help text where defaults are described
