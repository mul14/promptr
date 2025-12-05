# Change: Add promptr CLI for shared prompt collections

## Why
- Teams need a simple, repeatable way to share prompt libraries across Unix-like environments (including WSL) with minimal setup.
- A lightweight CLI should manage installing, updating, and linking prompt content into supported agent directories without unsafe symlink loops.

## What Changes
- Add an install script callable via curl or wget that clones a configurable prompt repo URL into `~/.prompts`, installs the CLI into `~/.local/bin`, ensures PATH is updated for the current shell, and supports WSL users; if no repo is provided via argument or env, the installer MUST stop with a clear error and instructions instead of cloning a default.
- Provide CLI commands for updating the prompt repo, self-updating the CLI, showing version/help output, enabling verbose logging, and linking prompt directories for supported agents (AntiGravity, OpenCode) with `--force` replacement.
- Enforce safe symlink creation that prevents nested or self-referential links when linking agent directories or all supported agents.

## Impact
- Affected specs: promptr-cli
- Affected code: installer script, CLI command parsing, symlink handling, update/self-update logic
