# Promptr

Promptr keeps your prompts in Git and links them into supported apps with safe symlinks. It is a Bash CLI for Linux, macOS, and FreeBSD.

## Install

1. Choose the Git URL for your prompt repo (example: `https://github.com/your/prompt.git`).
2. Run the installer:
   ```bash
   curl -fsSL https://raw.githubusercontent.com/mul14/promptr/master/setup.sh | bash -s -- https://github.com/your/prompt.git
   ```
3. Check it worked:
   ```bash
   promptr --version
   ```

Want to set the repo URL via an env var instead?
```bash
curl -fsSL https://raw.githubusercontent.com/mul14/promptr/master/setup.sh | PROMPTR_REPO=https://github.com/your/prompt.git bash
```
Want a custom filename prefix for copied prompts? Set it when running setup (it will be saved to `~/.config/promptr/prefix`; add it to your shell profile if you want to override per session):
```bash
curl -fsSL https://raw.githubusercontent.com/mul14/promptr/master/setup.sh | PROMPTR_REPO=https://github.com/your/prompt.git PROMPTR_PREFIX=my bash
```

## Everyday commands

- `promptr update` — pull the latest prompts into `~/.prompts`.
- `promptr link antigravity|codex|copilot|droid|gemini|opencode|claude|cursor|windsurf|roo|all` — copy prefixed `*.md` files to AntiGravity/Roo/Windsurf, copy prefixed `.prompt.md` files to Copilot (platform path), Droid at `~/.factory/commands`, Gemini TOML files at `~/.gemini/commands`, and Codex at `~/.codex/prompts`, and create symlinks for OpenCode/Claude/Cursor using the configured prefix. Add `--force` if a link already exists. Override copy prefixes with `PROMPTR_PREFIX` (default stored prefix `promptr`, filenames use `<prefix>-<name>`).
- `promptr self-update` — download the latest CLI script and save it to `~/.local/bin`.
- `promptr --help` — show all options.

## Where files live

- Prompts live in `~/.prompts` by default. Set `PROMPTR_DIR` before running commands to use a different location.
- The CLI installs to `~/.local/bin/promptr`. Make sure `~/.local/bin` is on your PATH.
- Set `PROMPTR_PREFIX` to change the filename prefix for copied prompts (set it without a trailing dash; default stored prefix `promptr`, producing `promptr-` filenames when copying). The last configured value is stored at `~/.config/promptr/prefix` and used automatically, including for undashed symlink names to OpenCode/Claude/Cursor.
- Codex prompt copies (when linked) are stored in `~/.codex/prompts` with filenames prefixed by `PROMPTR_PREFIX`.
- Copilot prompt copies (when linked) are stored with `PROMPTR_PREFIX` filename prefixes and `.prompt.md` suffixes in `~/Application Support/Code/User/prompts` on macOS or `~/.config/Code/User/prompts` on Linux.
- Droid prompt copies (when linked) are stored with `PROMPTR_PREFIX` filename prefixes in `~/.factory/commands`.
- Windsurf prompt copies (when linked) are stored with `PROMPTR_PREFIX` filename prefixes in `~/.codeium/windsurf/global_workflows`.
- Gemini command copies (when linked) are stored as TOML files with `PROMPTR_PREFIX` filename prefixes in `~/.gemini/commands` (`description` from frontmatter `description`, `prompt` from the Markdown body).
- Cursor symlink (when linked) lives at `~/.cursor/commands/<prefix>` using the undashed prefix value.

## Prompt format

Prompts are Markdown files with YAML frontmatter:
```yaml
---
title: "My Prompt"
description: ""
tags: ["tag1", "tag2"]
---

# Prompt Title

Write the prompt body here.
```

Most agents accept plain Markdown with light frontmatter. For widest compatibility, keep it simple:
```markdown
---
description: "Explain what each directory is for"
tags: ["programming", "docs"]
---

You are documenting this repository. List each top-level directory and briefly describe its purpose. Keep it concise and use bullet points.
```

## Troubleshooting

- PATH: add `~/.local/bin` to your shell PATH if `promptr` is not found.
- Repo missing: ensure your prompt repo is cloned into `~/.prompts` (or set `PROMPTR_DIR`).
- Symlinks: `promptr link` blocks nested or self-referential links. Remove bad links, then rerun with `--force` if you need to recreate them.
