## 1. Implementation
- [x] 1.1 Adjust Copilot filename handling to append `.prompt.md` after the `promptr-` prefix across link/update paths.
- [x] 1.2 Update unlink logic to remove the new `.prompt.md` filenames (and leave non-managed files intact).
- [x] 1.3 Refresh CLI docs/help text if they mention Copilot filenames or extensions.
- [x] 1.4 Validate behavior manually or with targeted checks (e.g., dry-run copy in temp HOME) to confirm Copilot files use the new suffix.
