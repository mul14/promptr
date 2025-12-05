## MODIFIED Requirements
### Requirement: Agent link management
Promptr CLI SHALL provide `promptr link [--force] <agent|all>` to create symlinks from `~/.prompts` into supported agent locations and prevent nested or self-referential links. Supported targets include AntiGravity (`~/.gemini/antigravity/global_workflows/promptr`), OpenCode (`~/.config/opencode/command/promptr`), and Claude (`~/.claude/commands/promptr`).

#### Scenario: Link single agent
- **WHEN** the user runs `promptr link <agent>` for any supported agent
- **THEN** the CLI creates a symlink at the agent's target path (e.g., `~/.gemini/antigravity/global_workflows/promptr`, `~/.config/opencode/command/promptr`, or `~/.claude/commands/promptr`) pointing to `~/.prompts` unless a conflicting or unsafe link exists

#### Scenario: Link all agents
- **WHEN** the user runs `promptr link all`
- **THEN** the CLI creates symlinks for AntiGravity, OpenCode, and Claude targets from `~/.prompts` using the same safety rules as single-agent linking

#### Scenario: Force replaces safe existing link
- **WHEN** the user runs `promptr link --force <agent>` and a symlink already exists at the target path
- **THEN** the CLI replaces the existing link with one pointing to `~/.prompts` after validating the path is not nested or self-referential

#### Scenario: Block nested or self-referential link
- **WHEN** the target path resolves inside `~/.prompts` or points back to itself through existing links
- **THEN** the CLI refuses to create or replace the link and reports the unsafe nested condition
