## MODIFIED Requirements
### Requirement: Agent link management
Promptr CLI SHALL provide `promptr link [--force] <agent|all>` to create symlinks from `~/.prompts` into supported agent locations (OpenCode at `~/.config/opencode/command/<prefix>`, Claude at `~/.claude/commands/<prefix>`, Cursor at `~/.cursor/commands/<prefix>`) using the configured/stored prefix (default `promptr`) with no trailing dash, and copy prompts for AntiGravity into `~/.gemini/antigravity/global_workflows`, Roo into `~/.roo/commands`, Droid into `~/.factory/commands`, Copilot into the Copilot prompts directory (`~/Application Support/Code/User/prompts` on macOS, `~/.config/Code/User/prompts` on Linux) using `<prefix>-<name>.prompt.md` filenames, and Codex into `~/.codex/prompts` (symlinks unsupported). AntiGravity, Roo, Droid, Copilot, and Codex copies MUST prefix each filename with the value of `PROMPTR_PREFIX` or the stored prefix in `~/.config/promptr/prefix`, defaulting to `promptr`, and append a trailing `-` when constructing filenames. Link operations MUST persist target state under `~/.config/promptr` so future updates can refresh copies and unlink can reverse the operation.

#### Scenario: Link single agent
- **WHEN** the user runs `promptr link <agent>` for any supported agent
- **THEN** the CLI creates a symlink at the target path for symlink-capable agents (OpenCode, Claude, Cursor) using the configured/stored prefix (default `promptr`) as the link name without a trailing dash, or copies all `*.md` files (excluding `README.md`) into the AntiGravity workflows directory, Roo commands directory, Droid commands directory with filenames using the configured `PROMPTR_PREFIX` or stored prefix (default `promptr`) plus a trailing dash, Copilot prompts directory for the current platform with filenames using the configured prefix, trailing dash, and `.prompt.md` suffix, or Codex prompts directory with the configured prefix plus trailing dash, then records the linked target in config unless a conflicting or unsafe link exists

#### Scenario: Link all agents
- **WHEN** the user runs `promptr link all`
- **THEN** the CLI creates symlinks for OpenCode, Claude, and Cursor using the configured/stored prefix (default `promptr`) as the link name without a trailing dash and copies the prompt `*.md` files (excluding `README.md`) into AntiGravity, Roo, Droid (with filenames using the configured `PROMPTR_PREFIX` or stored prefix plus trailing dash), Copilot (platform-specific prompts directory, filenames using the configured prefix plus trailing dash and `.prompt.md` suffix), and Codex (with filenames prefixed by the configured prefix plus trailing dash) using the same safety rules and records each successful target in config

#### Scenario: Force replaces safe existing link or copy
- **WHEN** the user runs `promptr link --force <agent>` and a symlink or prior copy already exists at the target path
- **THEN** the CLI replaces the existing asset after validating the path is not nested or self-referential (for symlinks), applies the configured prefix from `PROMPTR_PREFIX` or stored prefix for Droid, Copilot, and Codex copies with a trailing dash before filenames, uses `<prefix>-<name>.prompt.md` filenames for Copilot, replaces managed Droid files, and updates the config to reflect the link state

#### Scenario: Block nested or self-referential link
- **WHEN** the target path resolves inside `~/.prompts` or points back to itself through existing links
- **THEN** the CLI refuses to create or replace the link and reports the unsafe nested condition

### Requirement: Unlink command and link state cleanup
Promptr CLI SHALL provide `promptr unlink <agent|all>` to remove linked targets (symlinks or copied prompt files) and clear the corresponding entry in `~/.config/promptr`, leaving other targets untouched.

#### Scenario: Unlink single agent
- **WHEN** the user runs `promptr unlink <agent>` for a supported target that was previously linked
- **THEN** the CLI removes the symlink or deletes the copied prompt `*.md` files for AntiGravity, Roo, Droid (removing only the files prefixed by the configured `PROMPTR_PREFIX` or stored prefix with trailing dash, default prefix `promptr` producing `promptr-` filenames), Copilot (in the platform prompts directory, removing only files with the configured prefix plus trailing dash and `.prompt.md` suffix), Codex (removing only the files prefixed by the configured prefix plus trailing dash for Codex), or Cursor (removing the symlink at `~/.cursor/commands/<prefix>`), clears the stored link state for that target, and reports completion

#### Scenario: Unlink all agents
- **WHEN** the user runs `promptr unlink all`
- **THEN** the CLI removes all managed symlinks (including Cursor), removes AntiGravity prompt copies, removes Roo prompt copies, removes Droid prompt copies from `~/.factory/commands` (only the files prefixed by the configured `PROMPTR_PREFIX` or stored prefix with trailing dash), removes Copilot prompt copies from the platform prompts directory (only files with the configured prefix plus trailing dash and `.prompt.md` suffix), removes prefix-matching Codex prompt copies, clears all recorded link states, and reports completion
