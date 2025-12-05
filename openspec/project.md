# Project Context

## Purpose
Promptr is a Bash CLI that keeps prompt files in Git and links them into supported apps via safe symlinks. It aims to stay simple for beginners while preventing dangerous symlink setups.

## Tech Stack
- Bash (with POSIX-friendly constructs where possible)
- Git for sync and updates

## Project Conventions

### Code Style
- `#!/bin/bash` shebang, `set -euo pipefail`.
- 4-space indentation, `lower_snake_case` for functions/variables, prefer `local` inside functions.
- Small, single-purpose helpers (e.g., source validation, target guards, destination prep).
- Use `git -C` instead of subshell `cd`.

### Architecture Patterns
- Single CLI entry (`bin/promptr`) with commands: `update`, `self-update`, `link`, plus global flags.
- Self-update downloads the latest script from the hosted URL (`PROMPTR_CLI_URL` override) into `~/.local/bin`.
- Guard rails for symlinks: refuse nested or self-referential links; only replace links when `--force` is supplied.
- Configuration through environment (default prompts home: `~/.prompts`; override via `PROMPTR_DIR`).

### Testing Strategy
- Manual checks:
  - `bin/promptr --help` for parsing output.
  - `promptr update` inside `~/.prompts` to confirm Git pulls.
  - Optional symlink test in a temporary `HOME` if needed to avoid touching real paths.
- Run `shellcheck bin/promptr` when available.

### Git Workflow
- Concise, imperative commit messages (e.g., `add verbose logging`).
- Keep README aligned with actual CLI behavior; beginner-friendly tone.

## Domain Context
- Prompts live in `~/.prompts` by default; CLI install target is `~/.local/bin/promptr`.
- Supported symlink targets: Gemini AI global workflows (`~/.gemini/antigravity/global_workflows/promptr`) and OpenCode command prompts (`~/.config/opencode/command/promptr`).
- Link command blocks nested/self links and prevents overwriting non-symlinks without `--force`.

## Important Constraints
- Do not weaken symlink safety checks.
- Avoid adding dependencies beyond Bash, Git, curl/wget.
- Keep docs short and task-focused for beginners.

## External Dependencies
- Git for sync operations.
- curl or wget for bootstrap downloads when self-updating outside the repo copy.
