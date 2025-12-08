# Change: Update Copilot filename suffix

## Why
Copilot now expects prompt files to use the `.prompt.md` suffix. Current copies keep only the `.md` extension, so Copilot may not load them.

## What Changes
- Update Copilot copy/link/update flows to write prefixed filenames ending with `.prompt.md`.
- Ensure unlink removes the new filenames and ignores unmanaged files.

## Impact
- Affected specs: promptr-cli
- Affected code: bin/promptr (Copilot copy/unlink handling)
