## MODIFIED Requirements
### Requirement: Prompt repository updates
Promptr CLI SHALL provide an `update` command that pulls the latest content into `~/.prompts`, refreshes AntiGravity prompt copies when that target is linked in config, and reports errors clearly.

#### Scenario: Update succeeds
- **WHEN** the user runs `promptr update` with a valid git repository in `~/.prompts`
- **THEN** the CLI performs `git pull` in that directory and reports completion

#### Scenario: Update refreshes AntiGravity copies when linked
- **WHEN** the user runs `promptr update` and the stored link state indicates AntiGravity is linked
- **THEN** the CLI copies all `*.md` files except `README.md` into the AntiGravity workflows directory so the linked prompts stay in sync

#### Scenario: Update fails with missing repo
- **WHEN** the user runs `promptr update` and `~/.prompts` is missing or not a git repository
- **THEN** the CLI exits with an error explaining the missing or invalid repository

### Requirement: Agent link management
Promptr CLI SHALL provide `promptr link [--force] <agent|all>` to create symlinks from `~/.prompts` into supported agent locations (OpenCode at `~/.config/opencode/command/promptr`, Claude at `~/.claude/commands/promptr`) and copy prompts for AntiGravity into `~/.gemini/antigravity/global_workflows` (symlinks unsupported). Link operations MUST persist target state under `~/.config/promptr` so future updates can refresh copies and unlink can reverse the operation.

#### Scenario: Link single agent
- **WHEN** the user runs `promptr link <agent>` for any supported agent
- **THEN** the CLI creates a symlink at the target path for symlink-capable agents or copies all `*.md` files (excluding `README.md`) into the AntiGravity workflows directory without creating subfolders, then records the linked target in config unless a conflicting or unsafe link exists

#### Scenario: Link all agents
- **WHEN** the user runs `promptr link all`
- **THEN** the CLI creates symlinks for OpenCode and Claude and copies the prompt `*.md` files (excluding `README.md`) into AntiGravity using the same safety rules and records each successful target in config

#### Scenario: Force replaces safe existing link or copy
- **WHEN** the user runs `promptr link --force <agent>` and a symlink or prior AntiGravity copy already exists at the target path
- **THEN** the CLI replaces the existing asset after validating the path is not nested or self-referential (for symlinks) and updates the config to reflect the link state

#### Scenario: Block nested or self-referential link
- **WHEN** the target path resolves inside `~/.prompts` or points back to itself through existing links
- **THEN** the CLI refuses to create or replace the link and reports the unsafe nested condition

## ADDED Requirements
### Requirement: Unlink command and link state cleanup
Promptr CLI SHALL provide `promptr unlink <agent|all>` to remove linked targets (symlinks or AntiGravity copies) and clear the corresponding entry in `~/.config/promptr`, leaving other targets untouched.

#### Scenario: Unlink single agent
- **WHEN** the user runs `promptr unlink <agent>` for a supported target that was previously linked
- **THEN** the CLI removes the symlink or deletes the copied prompt `*.md` files for AntiGravity, clears the stored link state for that target, and reports completion

#### Scenario: Unlink all agents
- **WHEN** the user runs `promptr unlink all`
- **THEN** the CLI removes all managed symlinks, removes AntiGravity prompt copies, clears all recorded link states, and reports completion
