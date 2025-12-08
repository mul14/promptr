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
Promptr CLI SHALL provide an `update` command that pulls the latest content into `~/.prompts`, refreshes AntiGravity prompt copies when that target is linked in config, refreshes Copilot prompt copies (with `promptr-` filename prefixes) in the Copilot prompts directory (`~/Application Support/Code/User/prompts` on macOS, `~/.config/Code/User/prompts` on Linux) when linked, refreshes Codex prompt copies with prefixed filenames when linked, and reports errors clearly.

#### Scenario: Update succeeds
- **WHEN** the user runs `promptr update` with a valid git repository in `~/.prompts`
- **THEN** the CLI performs `git pull` in that directory and reports completion

#### Scenario: Update refreshes AntiGravity copies when linked
- **WHEN** the user runs `promptr update` and the stored link state indicates AntiGravity is linked
- **THEN** the CLI copies all `*.md` files except `README.md` into the AntiGravity workflows directory so the linked prompts stay in sync

#### Scenario: Update refreshes Copilot copies when linked
- **WHEN** the user runs `promptr update` and the stored link state indicates Copilot is linked
- **THEN** the CLI copies all `*.md` files except `README.md` into the Copilot prompts directory for the current platform (`~/Application Support/Code/User/prompts` on macOS, `~/.config/Code/User/prompts` on Linux) using `promptr-` filename prefixes, replacing managed files so Copilot commands stay in sync

#### Scenario: Update refreshes Codex copies when linked
- **WHEN** the user runs `promptr update` and the stored link state indicates Codex is linked
- **THEN** the CLI copies all `*.md` files except `README.md` into `~/.codex/prompts`, prefixes each copied filename with `promptr-`, and replaces existing prefixed files for the same prompts

#### Scenario: Update fails with missing repo
- **WHEN** the user runs `promptr update` and `~/.prompts` is missing or not a git repository
- **THEN** the CLI exits with an error explaining the missing or invalid repository

### Requirement: CLI self-update
Promptr CLI SHALL provide a `self-update` command that refreshes the installed CLI from the local repository copy and preserves executable permissions.

#### Scenario: Self-update refreshes CLI
- **WHEN** the user runs `promptr self-update`
- **THEN** the CLI copies its latest script from the repository into the installed PATH location with executable permissions and reports success

### Requirement: Agent link management
Promptr CLI SHALL provide `promptr link [--force] <agent|all>` to create symlinks from `~/.prompts` into supported agent locations (OpenCode at `~/.config/opencode/command/promptr`, Claude at `~/.claude/commands/promptr`) and copy prompts for AntiGravity into `~/.gemini/antigravity/global_workflows`, Roo into `~/.roo/commands`, Copilot into the Copilot prompts directory (`~/Application Support/Code/User/prompts` on macOS, `~/.config/Code/User/prompts` on Linux), and Codex into `~/.codex/prompts` (symlinks unsupported). Copilot and Codex copies MUST prefix each filename with `promptr-`. Link operations MUST persist target state under `~/.config/promptr` so future updates can refresh copies and unlink can reverse the operation.

#### Scenario: Link single agent
- **WHEN** the user runs `promptr link <agent>` for any supported agent
- **THEN** the CLI creates a symlink at the target path for symlink-capable agents or copies all `*.md` files (excluding `README.md`) into the AntiGravity workflows directory, Roo commands directory, Copilot prompts directory for the current platform with `promptr-` filename prefixes, or Codex prompts directory with `promptr-` prefixed filenames, then records the linked target in config unless a conflicting or unsafe link exists

#### Scenario: Link all agents
- **WHEN** the user runs `promptr link all`
- **THEN** the CLI creates symlinks for OpenCode and Claude and copies the prompt `*.md` files (excluding `README.md`) into AntiGravity, Roo, Copilot (platform-specific prompts directory, `promptr-` prefixed filenames), and Codex (with `promptr-` prefixed filenames for Codex) using the same safety rules and records each successful target in config

#### Scenario: Force replaces safe existing link or copy
- **WHEN** the user runs `promptr link --force <agent>` and a symlink or prior copy already exists at the target path
- **THEN** the CLI replaces the existing asset after validating the path is not nested or self-referential (for symlinks), applies `promptr-` prefixes for Copilot and Codex copies, replaces managed Copilot files in the platform prompts directory, and updates the config to reflect the link state

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

### Requirement: Unlink command and link state cleanup
Promptr CLI SHALL provide `promptr unlink <agent|all>` to remove linked targets (symlinks or copied prompt files) and clear the corresponding entry in `~/.config/promptr`, leaving other targets untouched.

#### Scenario: Unlink single agent
- **WHEN** the user runs `promptr unlink <agent>` for a supported target that was previously linked
- **THEN** the CLI removes the symlink or deletes the copied prompt `*.md` files for AntiGravity, Roo, Copilot (in the platform prompts directory, removing only the `promptr-` prefixed files), or Codex (removing only the `promptr-` prefixed files for Codex), clears the stored link state for that target, and reports completion

#### Scenario: Unlink all agents
- **WHEN** the user runs `promptr unlink all`
- **THEN** the CLI removes all managed symlinks, removes AntiGravity prompt copies, removes Roo prompt copies, removes Copilot prompt copies from the platform prompts directory (only `promptr-` prefixed files), removes `promptr-` prefixed Codex prompt copies, clears all recorded link states, and reports completion

