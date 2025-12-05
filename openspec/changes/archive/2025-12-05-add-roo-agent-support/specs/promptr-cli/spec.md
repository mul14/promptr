# Design Considerations for Roo Agent Support

## Architectural Decision
Roo differs from other supported agents (AntiGravity, OpenCode, Claude) in that it does not support sub-folders in its commands directory. While other agents symlink the entire ~/.prompts directory, Roo requires a flattened copy of *.md files.

## Trade-offs
- **Symlink vs Copy**: Using symlinks for consistency would fail for Roo due to sub-folder limitation. Copying ensures compatibility but means changes in ~/.prompts won't automatically reflect in ~/.roo/commands until re-linking.
- **Flattening**: File name conflicts could occur if subdirectories contain *.md files with identical names. The implementation should handle this by overwriting (last file wins) or warn, but for simplicity, overwrite as it's a copy operation.
- **Exclusion of README.md**: Assumes README.md is in the root of ~/.prompts; recursive search excludes any README.md at any level.

## Implementation Notes
- Use `find` to locate *.md files, exclude README.md, then `cp` with flattening (basename).
- Ensure ~/.roo/commands directory exists before copying.
- For --force, remove contents of ~/.roo/commands before copying.
- Integrate into existing link command logic with a conditional branch for "roo".</content>
<parameter name="filePath">openspec/changes/add-roo-agent-support/design.md