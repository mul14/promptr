## 1. Implementation
- [x] 1.1 Update `promptr-cli` spec to add Qwen TOML support under link/update/unlink with dashed prefix filenames and description/prompt mapping.
- [x] 1.2 Implement Qwen TOML generation in `bin/promptr`, mirroring Gemini/Windsurf copy patterns for link/update/unlink with link-state tracking.
- [x] 1.3 Update help/docs (README) to list Qwen target, path, and TOML mapping with prefix guidance.
- [x] 1.4 Validate with `openspec validate add-qwen-toml-support --strict` and run quick checks (`bin/promptr --help`, `shellcheck bin/promptr` if available).
