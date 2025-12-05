## MODIFIED Requirements

### Requirement: Agent link management
Promptr CLI SHALL provide `promptr link [--force] <agent|all>` to create symlinks from `~/.prompts` into supported agent locations and prevent nested or self-referential links. For Roo, SHALL copy *.md files (excluding README.md) from `~/.prompts` to `~/.roo/commands`, flattening subdirectories. Supported targets include AntiGravity (`~/.gemini/antigravity/global_workflows/promptr`), OpenCode (`~/.config/opencode/command/promptr`), Claude (`~/.claude/commands/promptr`), and Roo (`~/.roo/commands` via copy).

#### Scenario: Link Roo agent copies files
- **WHEN** the user runs `promptr link roo`
- **THEN** the CLI recursively copies all *.md files from `~/.prompts` (excluding README.md) to `~/.roo/commands`, flattening any subdirectory structure

#### Scenario: Link all agents includes Roo
- **WHEN** the user runs `promptr link all`
- **THEN** the CLI creates symlinks for AntiGravity, OpenCode, and Claude targets from `~/.prompts`, and copies *.md files to Roo target using the same safety rules as single-agent linking

#### Scenario: Force replaces for Roo removes and recopies
- **WHEN** the user runs `promptr link --force roo`
- **THEN** the CLI removes all existing files in `~/.roo/commands` and then copies the *.md files from `~/.prompts` (excluding README.md), flattening subdirectories</content>
<parameter name="filePath">openspec/changes/add-roo-agent-support/specs/promptr-cli/spec.md