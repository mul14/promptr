## 1. Implementation
- [x] 1.1 Add Copilot target handling that copies `*.md` (excluding `README.md`) from `~/.prompts` into the Copilot prompts directory (`~/Library/Application Support/Code/User/prompts` on macOS, `~/.config/Code/User/prompts` on Linux) with `promptr-` filename prefixes, supporting `--force` replacement and recording link state.
- [x] 1.2 Include Copilot in `link all` and ensure config tracking treats it the same as other targets for updates and unlinks.
- [x] 1.3 Refresh Copilot copies during `promptr update` when the target is recorded as linked.
- [x] 1.4 Extend unlink logic to remove Copilot prompt copies from the Copilot prompts directory (only the managed files) and clear its link state.
- [x] 1.5 Update CLI help/README to document the Copilot target name and destination path.
- [x] 1.6 Run `shellcheck bin/promptr` (or equivalent lint) and manual help/link checks if available.
