## 1. Implementation
- [x] 1.1 Update `promptr-cli` spec to add Gemini TOML support under link/update/unlink, including description/prompt mapping and filename rules.
- [x] 1.2 Implement Gemini handling in `bin/promptr`: render TOML files into `~/.gemini/commands` with dashed prefix and `.toml` extension; include in link/update; remove on unlink; track link state.
- [x] 1.3 Update help/docs (README) to list the Gemini target, path, and TOML format behavior; ensure prefix guidance stays consistent.
- [x] 1.4 Validate with `openspec validate add-gemini-toml-support --strict` and run quick checks (`bin/promptr --help`, `shellcheck bin/promptr` if available).
