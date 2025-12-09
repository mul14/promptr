## 1. Implementation
- [x] 1.1 Update spec requirements to describe configurable prompt filename prefix with default `promptr-` and `PROMPTR_PREFIX` override for affected agents.
- [x] 1.2 Adjust CLI prefix handling in link/update/unlink paths to honor `PROMPTR_PREFIX` with default fallback.
- [x] 1.3 Refresh README to mention the configurable prefix and defaults for copied prompts.
- [x] 1.4 Validate with `openspec validate add-configurable-prefix --strict` and run quick CLI help check if needed.
- [x] 1.5 Persist configured `PROMPTR_PREFIX` to `~/.config/promptr/prefix` and load it when env is absent.
- [x] 1.6 Update setup script messaging to store the prefix in config when provided.
