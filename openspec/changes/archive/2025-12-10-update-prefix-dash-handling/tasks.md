## 1. Implementation
- [x] 1.1 Update `promptr-cli` spec to capture the undashed prefix default and dashed copy filenames with undashed symlinks.
- [x] 1.2 Adjust prefix loading/persistence so the stored/default value omits the trailing dash while copy builders append it when needed.
- [x] 1.3 Update copy/link/unlink flows and help text to reflect the new prefix handling, using the prefix (no trailing dash) for symlink names and the dashed form for copies.
- [x] 1.4 Validate with `openspec validate update-prefix-dash-handling --strict` and run quick checks (`shellcheck bin/promptr`, `bin/promptr --help`).
