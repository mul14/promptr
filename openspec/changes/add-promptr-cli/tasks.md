## 1. Implementation
- [x] 1.1 Scaffold Bash CLI entrypoint and version/help output with verbose flag parsing.
- [x] 1.2 Implement installer to clone a configurable repo URL into `~/.prompts`, place the CLI into `~/.local/bin`, and update PATH for the current shell (WSL-friendly); if no repo is provided, exit with a clear error and guidance.
- [x] 1.3 Add `promptr update` to git pull the prompt repo and handle errors cleanly.
- [x] 1.4 Add `promptr self-update` to refresh the installed CLI from the repo copy.
- [x] 1.5 Add `promptr link [--force] <agent|all>` for AntiGravity and OpenCode paths with symlink safety (no nested/self-referential loops).
- [x] 1.6 Add minimal logging with `--verbose` and ensure commands emit clear user messages.
- [x] 1.7 Run shellcheck and basic manual CLI checks (help, version, update, link, PATH detection) in a temp HOME where needed. (shellcheck not available on host; manual checks performed, installer verified in temp HOME)
