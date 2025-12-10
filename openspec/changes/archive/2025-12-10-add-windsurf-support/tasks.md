## 1. Implementation
- [x] 1.1 Update `promptr-cli` spec to include Windsurf copy support under link, update, and unlink requirements.
- [x] 1.2 Implement Windsurf copy handling in `bin/promptr` for link/update/unlink with dashed filenames using the configured prefix (default `promptr`).
- [x] 1.3 Add Windsurf to CLI help text and README notes with target path and prefix behavior.
- [x] 1.4 Validate with `openspec validate add-windsurf-support --strict` and run quick checks (`bin/promptr --help`, `shellcheck bin/promptr` if available).
