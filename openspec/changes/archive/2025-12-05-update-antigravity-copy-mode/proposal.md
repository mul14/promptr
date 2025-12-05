# Change: Track and copy AntiGravity prompts instead of symlinking

## Why
- AntiGravity does not support symlinks or sub-folders, so the current `link` command cannot make prompts available there.
- We need a reliable way to remember whether AntiGravity was linked so `update` can refresh copied files without relying on symlink presence.
- Users expect symmetry between linking and unlinking, so they should be able to remove copied prompts and clear stored link state.

## What Changes
- Switch the AntiGravity target from symlinks to copying `*.md` files (excluding `README.md`) into the AntiGravity workflows directory.
- Persist link state in `~/.config/promptr` so copy operations only run for targets the user linked.
- Add an `unlink` command to remove copied AntiGravity prompts (and other targets) and clear stored link state.
- Extend `update` to refresh copied AntiGravity prompts when the target is linked in config.

## Impact
- Affected specs: promptr-cli (link/update behaviors, link-state storage, unlink command)
- Affected code: `bin/promptr`, potential new config handling under `~/.config/promptr`
