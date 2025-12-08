## 1. Implementation
- [x] 1.1 Add Droid target handling that copies `*.md` (excluding `README.md`) from `~/.prompts` into `~/.factory/commands` with `promptr-` filename prefixes, supporting `--force` replacement and recording link state.
- [x] 1.2 Include Droid in `link all` and ensure config tracking treats it the same as other targets for updates and unlinks.
- [x] 1.3 Refresh Droid copies during `promptr update` when the target is recorded as linked.
- [x] 1.4 Extend unlink logic to remove Droid prompt copies from `~/.factory/commands` (only the managed files) and clear its link state.
- [x] 1.5 Update CLI help/README to document the Droid target name and destination path.
- [x] 1.6 Run `shellcheck bin/promptr` (or equivalent lint) and manual help/link checks if available. (shellcheck not installed in this environment; manual help run)
