## 1. Implementation
- [x] 1.1 Update CLI help text to list the Claude target and link all coverage
- [x] 1.2 Add Claude target handling to `promptr link` with the `~/.claude/commands/promptr` path and safety checks consistent with other agents
- [x] 1.3 Ensure `link all` creates the Claude symlink alongside existing agents
- [x] 1.4 Update README examples or descriptions to mention the Claude link option
- [x] 1.5 Manual verification: run `promptr link claude` and `promptr link all` in a temp HOME to confirm symlink creation and `--force` replacement behavior
