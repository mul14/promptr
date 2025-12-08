# Change: Add Copilot support

## Why
People using GitHub Copilot want the same prompt library available across agents. Adding a Copilot target keeps Copilot commands in sync with `~/.prompts` without manual copies.

## What Changes
- Add a Copilot target to `promptr link` that copies Markdown prompts (excluding `README.md`) into the Copilot prompts directory (`~/Library/Application Support/Code/User/prompts` on macOS, `~/.config/Code/User/prompts` on Linux) with `promptr-` filename prefixes, `--force` replacement, and link-state tracking.
- Extend `link all`, `unlink`, and `update` flows to handle Copilot copies alongside existing agents.
- Refresh CLI help and README to describe the Copilot target and destination path.

## Impact
- Affected specs: `promptr-cli`
- Affected code: `bin/promptr` link/update/unlink helpers, help output, README
- Assumptions: Copilot consumes Markdown prompt files from the VS Code prompts directory; adjust if Copilot requires a different format.
