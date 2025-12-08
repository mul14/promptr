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

## Everyday commands

- `promptr update` — pull the latest prompts into `~/.prompts`.
- `promptr link antigravity|codex|copilot|droid|opencode|claude|roo|all` — copy `*.md` files to AntiGravity/Roo, copy prefixed `.prompt.md` files to Copilot (platform path), Droid at `~/.factory/commands`, and Codex at `~/.codex/prompts`, and create symlinks for OpenCode/Claude. Add `--force` if a link already exists.
- `promptr self-update` — download the latest CLI script and save it to `~/.local/bin`.
- `promptr --help` — show all options.

## Where files live

- Prompts live in `~/.prompts` by default. Set `PROMPTR_DIR` before running commands to use a different location.
- The CLI installs to `~/.local/bin/promptr`. Make sure `~/.local/bin` is on your PATH.
- Codex prompt copies (when linked) are stored in `~/.codex/prompts` with filenames prefixed by `promptr-`.
- Copilot prompt copies (when linked) are stored with `promptr-` filename prefixes and `.prompt.md` suffixes in `~/Application Support/Code/User/prompts` on macOS or `~/.config/Code/User/prompts` on Linux.
- Droid prompt copies (when linked) are stored with `promptr-` filename prefixes in `~/.factory/commands`.

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
