## 1. Implementation
- [x] 1.1 Update `promptr-cli` spec to cover Cursor symlink support under link/unlink flows.
- [x] 1.2 Implement Cursor symlink handling in `bin/promptr` link/unlink logic, reusing existing safety and prefix rules (undashed prefix for symlink names).
- [x] 1.3 Add Cursor to help text and docs (README/setup notes) describing the new link target and path.
- [x] 1.4 Validate with `openspec validate add-cursor-support --strict` and run quick checks (`bin/promptr --help`, `shellcheck bin/promptr` if available).
