<!-- OPENSPEC:START -->
# OpenSpec Instructions

These instructions are for AI assistants working in this project.

Always open `@/openspec/AGENTS.md` when the request:
- Mentions planning or proposals (words like proposal, spec, change, plan)
- Introduces new capabilities, breaking changes, architecture shifts, or big performance/security work
- Sounds ambiguous and you need the authoritative spec before coding

Use `@/openspec/AGENTS.md` to learn:
- How to create and apply change proposals
- Spec format and conventions
- Project structure and guidelines

Keep this managed block so 'openspec update' can refresh the instructions.

<!-- OPENSPEC:END -->

# Repository Guidelines

## Project Structure & Module Organization
- `bin/promptr`: Bash CLI that syncs the repo, links prompt directories, and handles self-updates.
- `prompts/`: Markdown prompts with YAML frontmatter; keeps examples and contributed prompts.
- `setup.sh`: Installer that clones to `~/.prompts`, copies the CLI to `~/.local/bin`, and updates PATH.
- `README.md`: User-facing overview and usage notes; keep it consistent with CLI behavior.

## Build, Test, and Development Commands
- `./setup.sh [repo_url] [clone_dir]`: Install locally; defaults to cloning into `~/.prompts`.
- `bin/promptr --help` or `promptr --help`: Show available commands once installed.
- `promptr update`: Pull latest prompts into `~/.prompts`.
- `promptr link [--force] antigravity|opencode|all`: Create symlinks to app-specific prompt directories; `--force` only removes existing symlinks.
- `promptr self-update`: Download the CLI from the hosted URL (override with `PROMPTR_CLI_URL`) to `~/.local/bin` and refresh execute permissions.

## Coding Style & Naming Conventions
- Shell scripts target Bash; keep the `#!/bin/bash` shebang and prefer portable POSIX constructs where feasible.
- Indent with 4 spaces, use `lower_snake_case` for functions and variables, and prefer `local` inside functions.
- Favor small, single-purpose functions (e.g., `create_symlink`, `check_repo_exists`) and explicit exit codes.
- Run `shellcheck bin/promptr` before submitting when changing shell scripts.
- Prefer `git -C` over subshell `cd` for repo commands.
- Guard symlink logic with clear helpers (source validation, target path checks, destination prep) to avoid recursion and accidental overwrites; only allow replacement when `--force` is set.

## Testing Guidelines
- No automated test suite yet; rely on fast manual checks:
  - `bin/promptr --help` to confirm argument parsing.
  - `promptr update` inside `~/.prompts` to verify Git pulls.
  - Symlink tests touch real home paths; if you must run them, copy `~/.prompts` into a temporary `HOME` (e.g., `tmp_home=$(mktemp -d); cp -r ~/.prompts \"$tmp_home\"; HOME=$tmp_home promptr link --force all`).
- Keep new prompts valid YAML frontmatter and Markdown; prefer short titles and tag arrays.

## Commit & Pull Request Guidelines
- Use concise, imperative commit messages (e.g., `add verbose logging`); include `[skip ci]` only when work is intentionally in progress.
- In PRs: describe the change, list manual checks run, and note any symlink or setup impacts. Link issues when applicable and include screenshots only if modifying user-facing docs or prompt content formatting.

## Security & Configuration Tips
- Avoid embedding secrets in prompt files or frontmatter.
- Symlink safety is enforced: the CLI refuses nested or self-referential links. Do not bypass these checks; instead, clean problematic links before linking.
- Keep beginner-facing docs short and task-focused; surface the simplest install and daily commands first.
