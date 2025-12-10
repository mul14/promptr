# Change: Add Qwen TOML command support

## Why
Qwen commands live under `~/.qwen/commands` and use TOML. Users want their prompts available there without manual conversion from Markdown.

## What Changes
- Add Qwen as a copy-based target that generates TOML files in `~/.qwen/commands` using the configured/stored prefix (default `promptr`) plus a trailing dash and `.toml` extension.
- Map `description` from YAML frontmatter `description` (empty when missing) and `prompt` from the Markdown body.
- Include Qwen in link/update/unlink flows with existing prefix persistence and link-state tracking.

## Impact
- Affected specs: promptr-cli
- Affected code: bin/promptr, README/help text
