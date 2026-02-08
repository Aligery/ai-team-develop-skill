# /team-develop — Virtual IT Team Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

A skill that assembles a virtual IT team to take a feature from idea to implementation. Each team member is a specialized subagent with a focused role, working as a pipeline with user approval at every stage.

**Supported platforms:** [Claude Code](https://docs.anthropic.com/en/docs/claude-code) | [OpenCode](https://opencode.ai)

> **[Русская версия / Russian version](README_RU.md)**

## Quick Start

```bash
# One-line install (Claude Code + OpenCode)
curl -fsSL https://raw.githubusercontent.com/anthropics/team-develop-skill/main/install.sh | bash
```

Or clone and run locally:

```bash
git clone https://github.com/anthropics/team-develop-skill.git
cd team-develop-skill
./install.sh
```

Then start a new session and type:

```
/team-develop
```

## Team Roles

| Role | Responsibility |
|------|---------------|
| **Team Lead** | You (AI in main conversation). Orchestrates the pipeline, delegates work, never writes code. |
| **Product Engineer** | Defines product value, user stories, acceptance criteria. Cuts scope ruthlessly (YAGNI). |
| **Analyst** | Decomposes requirements into bite-sized implementation tasks with exact file paths and TDD steps. |
| **UX Designer** | Validates user flows, defines UI states, adds accessibility and interaction criteria. |
| **QA Engineer** | Defines Definition of Done per task, writes test scenarios (Given/When/Then). |
| **Software Engineer** | Implements code following TDD. Commits after each task. Builds exactly what's specified. |

## Pipeline

```
/team-develop
    |
    Phase 0: Discovery (brainstorming) ── CHECKPOINT
    |
    Phase 1: Product Engineer ── CHECKPOINT
    |
    Phase 2: Analyst ── CHECKPOINT
    |
    Phase 3: UX Designer ── CHECKPOINT
    |
    Phase 4: QA Engineer ── CHECKPOINT
    |
    Phase 5: Software Engineer ── CHECKPOINT (per task)
    |
    Phase 6: QA + UX Validation ── CHECKPOINT
    |
    Done!
```

Every checkpoint presents the stage output to you and waits for approval. You can approve, request changes, or skip any stage.

## Installation

### Automatic (recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/anthropics/team-develop-skill/main/install.sh | bash
```

The script auto-detects your platform (Claude Code, OpenCode, or both) and installs skill files and slash commands to the correct locations.

Options:

```bash
# Install for Claude Code only
./install.sh --claude

# Install for OpenCode only
./install.sh --opencode

# Install for both (default)
./install.sh

# Uninstall
./install.sh --uninstall
```

### Manual: Claude Code

```bash
git clone https://github.com/anthropics/team-develop-skill.git /tmp/team-develop-skill

# Copy skill files
mkdir -p ~/.claude/skills
cp -r /tmp/team-develop-skill/skills/team-develop ~/.claude/skills/team-develop

# Copy slash command
mkdir -p ~/.claude/commands
cp /tmp/team-develop-skill/commands/team-develop.md ~/.claude/commands/team-develop.md
```

### Manual: OpenCode

OpenCode discovers skills from `~/.claude/skills/` automatically. The only difference is the command location:

```bash
git clone https://github.com/anthropics/team-develop-skill.git /tmp/team-develop-skill

# Copy skill files (shared path with Claude Code)
mkdir -p ~/.claude/skills
cp -r /tmp/team-develop-skill/skills/team-develop ~/.claude/skills/team-develop

# Copy slash command (OpenCode-specific path)
mkdir -p ~/.config/opencode/commands
cp /tmp/team-develop-skill/commands/team-develop.md ~/.config/opencode/commands/team-develop.md
```

### Symlink (for development)

```bash
git clone https://github.com/anthropics/team-develop-skill.git ~/team-develop-skill

# Skill (works for both Claude Code and OpenCode)
ln -s ~/team-develop-skill/skills/team-develop ~/.claude/skills/team-develop

# Command — Claude Code
ln -s ~/team-develop-skill/commands/team-develop.md ~/.claude/commands/team-develop.md

# Command — OpenCode
ln -s ~/team-develop-skill/commands/team-develop.md ~/.config/opencode/commands/team-develop.md
```

### Verify installation

Start a new session (Claude Code or OpenCode) and type:

```
/team-develop
```

You should see the skill activate and begin the discovery phase.

## File Structure

```
team-develop-skill/
├── install.sh                                 # Automatic installer
├── README.md                                  # Documentation (English)
├── README_RU.md                               # Documentation (Russian)
├── commands/
│   └── team-develop.md                        # Slash command entry point
└── skills/
    └── team-develop/
        ├── SKILL.md                           # Main orchestration logic
        ├── role-product-engineer.md           # Product Engineer prompt
        ├── role-analyst.md                    # Analyst prompt
        ├── role-ux-designer.md                # UX Designer prompt
        ├── role-qa-engineer.md                # QA Engineer prompt
        ├── role-software-engineer.md          # Software Engineer prompt
        └── role-validators.md                 # QA + UX validation prompts
```

## Artifacts

During execution, the skill creates planning documents in your project:

```
docs/plans/
├── YYYY-MM-DD-<feature>-design.md             # Brainstorming output
├── YYYY-MM-DD-<feature>-product-spec.md       # User stories & acceptance criteria
├── YYYY-MM-DD-<feature>-tasks.md              # Implementation plan
├── YYYY-MM-DD-<feature>-ux-criteria.md        # UX requirements
├── YYYY-MM-DD-<feature>-test-plan.md          # Test scenarios & DoD
└── YYYY-MM-DD-<feature>-validation.md         # Final validation report
```

## Recommended Skills

The team agents auto-discover and apply available skills. For best results, install:

- [superpowers](https://github.com/anthropics/claude-code-superpowers) — provides brainstorming, writing-plans, TDD, verification, debugging
- [web-design-guidelines](https://github.com/anthropics/claude-code-web-design-guidelines) — UX Designer uses this for validation

## Customization

Each role prompt is a separate markdown file. To customize a role:

1. Edit the corresponding `role-*.md` file
2. Modify the output format, instructions, or quality checklist
3. The orchestration (SKILL.md) stays unchanged

To add a new role:

1. Create `role-new-role.md` following the same template structure
2. Add the phase to SKILL.md's pipeline
3. Update the checkpoint flow

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) or [OpenCode](https://opencode.ai) CLI
- No additional dependencies — the skill uses only built-in tools (Task, Read, Write, Glob)

## License

MIT
