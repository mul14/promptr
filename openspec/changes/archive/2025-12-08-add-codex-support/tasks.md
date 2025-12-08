## 1. Implementation
- [x] 1.1 Add Codex target handling that copies `*.md` (excluding `README.md`) from `~/.prompts` into `~/.codex/prompts` with a `promptr-` filename prefix and `--force` replacement support.
- [x] 1.2 Include Codex in `link all` and link state tracking so updates and unlinks recognize the target.
- [x] 1.3 Extend unlink logic to remove prefixed Codex copies without touching other files in `~/.codex/prompts`.
- [x] 1.4 Refresh Codex copies during `promptr update` when the target is linked.
- [x] 1.5 Update CLI help/README to document the Codex target, prefixing rule, and all-target behavior.
- [x] 1.6 Run `shellcheck bin/promptr` (or equivalent lint) to validate shell changes (shellcheck not installed in environment; command not found).
