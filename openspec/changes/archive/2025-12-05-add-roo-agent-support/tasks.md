# Add Roo Code Agent Support

## Summary
Add support for the Roo code agent by extending the `promptr link` command to include "roo" as a supported agent. Unlike other agents that use symlinks, Roo requires copying *.md files (excluding README.md) directly to ~/.roo/commands, flattening any subdirectories since Roo does not support sub-folders.

## Motivation
Users want to use Promptr-managed prompts with the Roo code agent. Roo stores workflows in ~/.roo/commands but lacks sub-folder support, necessitating a copy operation instead of symlinking.

## Impact
- Extends CLI functionality without breaking existing behavior
- Adds Roo as a fourth supported agent alongside AntiGravity, OpenCode, and Claude
- Introduces copy-based linking for agents that require it

## Implementation Approach
Modify the `link` command to detect "roo" and perform a recursive copy of *.md files from ~/.prompts to ~/.roo/commands, excluding README.md and flattening directory structure.</content>
<parameter name="filePath">openspec/changes/add-roo-agent-support/proposal.md