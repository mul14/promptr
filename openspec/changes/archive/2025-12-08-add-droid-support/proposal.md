# Change: Add Droid support

## Why
Users running Droid keep custom commands in `~/.factory/commands` and want the same prompt library available there without manual copies.

## What Changes
- Add a Droid target to `promptr link` that copies Markdown prompts (excluding `README.md`) into `~/.factory/commands` with `promptr-` filename prefixes, supports `--force` replacement, and records link state.
- Extend `link all`, `unlink`, and `update` flows to handle Droid copies alongside existing agents.
- Refresh CLI help and README to describe the Droid target and destination path.

## Impact
- Affected specs: `promptr-cli`
- Affected code: `bin/promptr` link/update/unlink helpers, help output, README
- Open questions: confirm whether Droid expects filename prefixes or additional formatting beyond plain Markdown copies.
