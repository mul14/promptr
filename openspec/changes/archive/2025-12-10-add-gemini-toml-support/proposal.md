# Change: Add Gemini TOML command support

## Why
Gemini commands live under `~/.gemini/commands` and expect TOML files. Users want their prompts available there without manual conversion from Markdown.

## What Changes
- Add Gemini as a supported target that copies prompts as TOML files into `~/.gemini/commands` using the configured/stored prefix (default `promptr`) plus a trailing dash and a `.toml` extension.
- Convert Markdown prompts to TOML with `description` from frontmatter `description` (empty when missing) and `prompt` from the Markdown body.
- Include Gemini in link/update/unlink flows with existing link-state tracking and prefix persistence.

## Impact
- Affected specs: promptr-cli
- Affected code: bin/promptr, README/help text
