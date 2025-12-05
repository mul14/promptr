## Context
AntiGravity cannot consume symlinks or nested folders, so linking must copy prompt files. Without a symlink marker, the CLI needs a persisted record of which targets were linked to know when to refresh copies during `update` or to safely undo them.

## Goals / Non-Goals
- Goals: copy AntiGravity prompts, track link state across runs, add unlink symmetry, keep behavior for other targets intact.
- Non-Goals: redesign of other agents, full-blown config management tooling, support for arbitrary target directories.

## Decisions
- Decision: Store link state under `~/.config/promptr` (simple file, likely key/value or per-target files) to mark linked targets, especially AntiGravity.
- Decision: Copy only `*.md` files excluding `README.md` into the AntiGravity workflows directory; avoid recreating subfolder structure.
- Decision: `update` will trigger AntiGravity copy refresh only when the config indicates it was linked (avoids accidental writes).
- Decision: Provide `unlink` to remove copied AntiGravity files and clear link state; for symlink-based targets it will remove symlinks and clear state as well.

## Risks / Trade-offs
- Risk: Config drift (linked state mismatched with actual files). Mitigation: `unlink` cleans config and files; `link` rewrites state on success.
- Risk: Overwriting user files in AntiGravity directory. Mitigation: limit to `*.md` and optionally allow `--force` handling similar to existing behavior.

## Open Questions
- Should `link all` automatically record AntiGravity as linked even if copy succeeds partially (e.g., missing prompts)? (Assume yes on success; revisit if needed.)
- Should `unlink` leave user-added files in the AntiGravity directory? (Assume removal only for files we copied, or the configured set.)
