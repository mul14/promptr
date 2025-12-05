## 1. Implementation
- [x] 1.1 Add config persistence under `~/.config/promptr` to record linked targets
- [x] 1.2 Update `link` handling so AntiGravity copies `*.md` (excluding `README.md`) and records link state
- [x] 1.3 Introduce `unlink` command to remove copies/symlinks per target and clear config entries
- [x] 1.4 Extend `update` to refresh AntiGravity copies when linked in config
- [x] 1.5 Refresh CLI help/usage messaging to cover new behaviors and commands

## 2. Validation
- [x] 2.1 Run `openspec validate update-antigravity-copy-mode --strict`
- [x] 2.2 Manual sanity checks: `promptr --help`, `promptr link antigravity`, `promptr unlink antigravity`, `promptr update` with AntiGravity linked (update hit expected git fetch failure in sandbox)
