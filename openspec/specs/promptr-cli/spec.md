# promptr-cli Specification

## Purpose
TBD - created by archiving change add-promptr-cli. Update Purpose after archive.
## Requirements
### Requirement: CLI installation script
Promptr SHALL provide a single-command installer (curl or wget) that clones a configurable prompt repository URL into `~/.prompts`, installs the CLI into `~/.local/bin`, ensures the path is on the user's PATH (adding it based on the current shell if needed), and supports Unix-like systems including WSL. If no repository is provided via argument or environment variable, the installer MUST exit with a clear error and instructions instead of cloning a default.

#### Scenario: Install via curl on Unix-like system with provided repo
- **WHEN** the user runs the published curl install command on a Unix-like system (including WSL) and supplies a repository via argument or environment variable
- **THEN** the installer clones the provided repository into `~/.prompts`, installs `promptr` into `~/.local/bin` with execute permission, and ensures `~/.local/bin` is on PATH for the current shell

#### Scenario: Install via wget on Unix-like system with provided repo
- **WHEN** the user runs the published wget install command on a Unix-like system (including WSL) and supplies a repository via argument or environment variable
- **THEN** the installer clones the provided repository into `~/.prompts`, installs `promptr` into `~/.local/bin` with execute permission, and ensures `~/.local/bin` is on PATH for the current shell

#### Scenario: Missing repository fails with guidance
- **WHEN** the user runs the installer without providing a repository via argument or environment variable
- **THEN** the installer exits with an error explaining that a repository is required and shows how to pass it (e.g., argument or `PROMPTR_REPO`)

### Requirement: Prompt repository updates
Promptr CLI SHALL provide an `update` command that pulls the latest content into `~/.prompts` and reports errors clearly.

#### Scenario: Update succeeds
- **WHEN** the user runs `promptr update` with a valid git repository in `~/.prompts`
- **THEN** the CLI performs `git pull` in that directory and reports completion

#### Scenario: Update fails with missing repo
- **WHEN** the user runs `promptr update` and `~/.prompts` is missing or not a git repository
- **THEN** the CLI exits with an error explaining the missing or invalid repository

### Requirement: CLI self-update
Promptr CLI SHALL provide a `self-update` command that refreshes the installed CLI from the local repository copy and preserves executable permissions.

#### Scenario: Self-update refreshes CLI
- **WHEN** the user runs `promptr self-update`
- **THEN** the CLI copies its latest script from the repository into the installed PATH location with executable permissions and reports success

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

### Requirement: CLI interface and logging
Promptr CLI SHALL provide `--version`, `--help`, and `--verbose` flags; `--verbose` MUST emit additional operational logs without changing behavior.

#### Scenario: Show version and help
- **WHEN** the user runs `promptr --version` or `promptr --help`
- **THEN** the CLI prints the version information or usage summary respectively and exits without side effects

#### Scenario: Verbose logging enabled
- **WHEN** the user runs any command with `--verbose`
- **THEN** the CLI prints additional diagnostic messages while performing the requested action, and the core behavior remains unchanged

