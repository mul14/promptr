## MODIFIED Requirements
### Requirement: Prompt repository updates
Promptr CLI SHALL provide an `update` command that pulls the latest content into `~/.prompts`, refreshes AntiGravity prompt copies when that target is linked in config using filenames composed of the configured/stored prefix (default `promptr`) plus a trailing `-` before the basename, refreshes Roo prompt copies with the same dashed prefix scheme, refreshes Droid prompt copies in `~/.factory/commands` with filename prefixes composed of the configured/stored prefix plus a trailing `-` before the basename, refreshes Copilot prompt copies with `<prefix>-<name>.prompt.md` filenames using the same configurable prefix default, refreshes Codex prompt copies with prefixed filenames using the configured prefix plus a trailing dash, and reports errors clearly. When `PROMPTR_PREFIX` is set, the CLI SHALL persist that value (without forcing a trailing dash) to `~/.config/promptr/prefix` for reuse when the environment variable is unset.

#### Scenario: Update succeeds
- **WHEN** the user runs `promptr update` with a valid git repository in `~/.prompts`
- **THEN** the CLI performs `git pull` in that directory and reports completion

#### Scenario: Update refreshes AntiGravity copies when linked
- **WHEN** the user runs `promptr update` and the stored link state indicates AntiGravity is linked
- **THEN** the CLI copies all `*.md` files except `README.md` into the AntiGravity workflows directory using filenames that start with the configured prefix (default `promptr`) plus a trailing dash so the linked prompts stay in sync

#### Scenario: Update refreshes Roo copies when linked
- **WHEN** the user runs `promptr update` and the stored link state indicates Roo is linked
- **THEN** the CLI copies all `*.md` files except `README.md` into `~/.roo/commands` using filenames that start with the configured prefix (default `promptr`) plus a trailing dash so Roo prompts stay in sync

#### Scenario: Update refreshes Droid copies when linked
- **WHEN** the user runs `promptr update` and the stored link state indicates Droid is linked
- **THEN** the CLI copies all `*.md` files except `README.md` into `~/.factory/commands` using filenames composed of the configured prefix from `PROMPTR_PREFIX` or the stored prefix (default `promptr`) plus a trailing `-` before the basename, replacing managed files so Droid commands stay in sync

#### Scenario: Update refreshes Copilot copies when linked
- **WHEN** the user runs `promptr update` and the stored link state indicates Copilot is linked
- **THEN** the CLI copies all `*.md` files except `README.md` into the Copilot prompts directory for the current platform (`~/Application Support/Code/User/prompts` on macOS, `~/.config/Code/User/prompts` on Linux) using filenames composed of the configured prefix from `PROMPTR_PREFIX` or the stored prefix (default `promptr`), a trailing `-`, the prompt name, and the `.prompt.md` suffix, replacing managed files so Copilot commands stay in sync

#### Scenario: Update refreshes Codex copies when linked
- **WHEN** the user runs `promptr update` and the stored link state indicates Codex is linked
- **THEN** the CLI copies all `*.md` files except `README.md` into `~/.codex/prompts`, prefixes each copied filename with the configured prefix from `PROMPTR_PREFIX` or the stored prefix (default `promptr`) plus a trailing `-`, and replaces existing prefixed files for the same prompts

#### Scenario: Prefix persisted and reused
- **WHEN** the user runs any `promptr` command with `PROMPTR_PREFIX` set
- **THEN** the CLI saves that prefix (without adding a trailing dash) to `~/.config/promptr/prefix`, applies the saved value on subsequent runs when the environment variable is not set, and continues to append the trailing dash only when constructing copied filenames while symlink targets remain undashed

#### Scenario: Update fails with missing repo
- **WHEN** the user runs `promptr update` and `~/.prompts` is missing or not a git repository
- **THEN** the CLI exits with an error explaining the missing or invalid repository

### Requirement: Agent link management
Promptr CLI SHALL provide `promptr link [--force] <agent|all>` to create symlinks from `~/.prompts` into supported agent locations (OpenCode at `~/.config/opencode/command/<prefix>`, Claude at `~/.claude/commands/<prefix>`) using the configured/stored prefix (default `promptr`) with no trailing dash, and copy prompts for AntiGravity into `~/.gemini/antigravity/global_workflows`, Roo into `~/.roo/commands`, Droid into `~/.factory/commands`, Copilot into the Copilot prompts directory (`~/Application Support/Code/User/prompts` on macOS, `~/.config/Code/User/prompts` on Linux) using `<prefix>-<name>.prompt.md` filenames, and Codex into `~/.codex/prompts` (symlinks unsupported). AntiGravity, Roo, Droid, Copilot, and Codex copies MUST prefix each filename with the value of `PROMPTR_PREFIX` or the stored prefix in `~/.config/promptr/prefix`, defaulting to `promptr`, and append a trailing `-` when constructing filenames. Link operations MUST persist target state under `~/.config/promptr` so future updates can refresh copies and unlink can reverse the operation.

#### Scenario: Link single agent
- **WHEN** the user runs `promptr link <agent>` for any supported agent
- **THEN** the CLI creates a symlink at the target path for symlink-capable agents using the configured/stored prefix (default `promptr`) as the link name without a trailing dash, or copies all `*.md` files (excluding `README.md`) into the AntiGravity workflows directory, Roo commands directory, Droid commands directory with filenames using the configured `PROMPTR_PREFIX` or stored prefix (default `promptr`) plus a trailing dash, Copilot prompts directory for the current platform with filenames using the configured prefix, trailing dash, and `.prompt.md` suffix, or Codex prompts directory with the configured prefix plus trailing dash, then records the linked target in config unless a conflicting or unsafe link exists

#### Scenario: Link all agents
- **WHEN** the user runs `promptr link all`
- **THEN** the CLI creates symlinks for OpenCode and Claude using the configured/stored prefix (default `promptr`) as the link name without a trailing dash and copies the prompt `*.md` files (excluding `README.md`) into AntiGravity, Roo, Droid (with filenames using the configured `PROMPTR_PREFIX` or stored prefix plus trailing dash), Copilot (platform-specific prompts directory, filenames using the configured prefix plus trailing dash and `.prompt.md` suffix), and Codex (with filenames prefixed by the configured prefix plus trailing dash) using the same safety rules and records each successful target in config

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
- **THEN** the CLI removes the symlink or deletes the copied prompt `*.md` files for AntiGravity, Roo, Droid (removing only the files prefixed by the configured `PROMPTR_PREFIX` or stored prefix with trailing dash, default prefix `promptr` producing `promptr-` filenames), Copilot (in the platform prompts directory, removing only files with the configured prefix plus trailing dash and `.prompt.md` suffix), or Codex (removing only the files prefixed by the configured prefix plus trailing dash for Codex), clears the stored link state for that target, and reports completion

#### Scenario: Unlink all agents
- **WHEN** the user runs `promptr unlink all`
- **THEN** the CLI removes all managed symlinks, removes AntiGravity prompt copies, removes Roo prompt copies, removes Droid prompt copies from `~/.factory/commands` (only the files prefixed by the configured `PROMPTR_PREFIX` or stored prefix with trailing dash), removes Copilot prompt copies from the platform prompts directory (only files with the configured prefix plus trailing dash and `.prompt.md` suffix), removes prefix-matching Codex prompt copies, clears all recorded link states, and reports completion
