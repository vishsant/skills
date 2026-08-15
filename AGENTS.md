# AGENTS.md

You're in a skills repository. Before you do anything, read this.

## What This Repo Is

A collection of agent skills I use in production. Each skill solves one real problem and has been tested for ≥1 week before it ships. Nothing here is theoretical.

## Before You Add a Skill

**You must follow these gates:**

1. **Real use** — Use the skill in production for at least 1 week. Document the use case.
2. **Tight scope** — Solves one problem well. No "might be useful someday."
3. **Naming** — Matches `<prefix>-<skill-name>` (e.g., `eng-tdd`, `prod-grilling`). See [CONTRIBUTING.md](CONTRIBUTING.md).

If you're tempted to skip these, read [CONTRIBUTING.md](CONTRIBUTING.md) first.

## Structure

Skills are flat in `.agents/skills/` with prefixed names:
- `eng-*` for engineering/code
- `prod-*` for productivity
- `sys-*` for systems/infrastructure
- `write-*` for writing/content

Why this structure? See [ADR 0001](.agents/adr/0001-flat-prefixed-skills.md).

## Adding a Skill

1. Create `.agents/skills/<prefix>-<name>/`
2. Write `SKILL.md` with frontmatter (name, description) + markdown content
3. Add `agents/openai.yaml` (optional but recommended)
4. Update README.md skill table
5. Test locally:
   ```bash
   ln -s $(pwd)/.agents/skills/eng-my-skill ~/.claude/skills/
   # Use it in Claude Code
   rm ~/.claude/skills/eng-my-skill  # Unlink when done
   ```

Full details: [CONTRIBUTING.md](CONTRIBUTING.md)

## Questions?

Check [README.md](README.md) or look at existing skills for patterns.
