# Contributing Skills

Before you ship a skill, it must pass two gates:

1. **Real use** — You've used it in production for at least a week. Document the use case.
2. **Tight spec** — The skill is narrow and solves one problem well. No "I might need this someday."

## Adding a Skill

### 1. Create the directory

Skills live in `.agents/skills/` with a prefixed name. Naming rules:

- Format: `<prefix>-<skill-name>`
- Prefixes: `eng-`, `prod-`, `sys-`, `write-`
- Regex: `^[a-z]+-[a-z0-9\-]+$`
- Examples: `eng-tdd`, `prod-grilling`, `sys-debugging-bmc`

```bash
mkdir -p .agents/skills/eng-my-skill
```

### 2. Write SKILL.md

SKILL.md is the only required file. See [eng-writing-commits](https://github.com/vishsant/skills/tree/main/.agents/skills/eng-writing-commits) for a template.

**Frontmatter (YAML):**
```yaml
---
name: eng-my-skill
description: One sentence. Use it when X.
---
```

**Content (Markdown):**
- Keep it short (< 2000 words for most skills)
- Include examples or recipes if the skill is procedural
- Reference external docs sparingly — skills should be self-contained

### 3. Add agents/openai.yaml (optional)

Describe how Claude/OpenAI models should invoke the skill:

```yaml
interface:
  display_name: "My Skill"
  short_description: "What it does"
```

### 4. Update the README

Add one row to the skill table:

```markdown
| [eng-my-skill](https://github.com/vishsant/skills/tree/main/.agents/skills/eng-my-skill) | Engineering | Short description |
```

### 5. Test it

Install the skill locally and use it for real:

```bash
ln -s $(pwd)/.agents/skills/eng-my-skill ~/.claude/skills/
# Use it in Claude Code
rm ~/.claude/skills/eng-my-skill  # Unlink when done
```

## Before You Ship

- [ ] Skill has a SKILL.md with name, description, and content
- [ ] Directory name matches `<prefix>-<skill-name>` regex
- [ ] agents/openai.yaml exists (optional but recommended)
- [ ] You've used the skill in production for ≥1 week
- [ ] README.md skill table is updated
- [ ] No typos or broken references

## Design Principles

- **Tight scope** — one job, done well
- **Self-contained** — no external docs required (link sparingly)
- **Real use** — you use it, not hypothetical
- **Portable** — works on Claude Code, Codex, pi, any agent

If your skill is doing too much, split it.

## Questions?

Open an issue or check existing skills for patterns.
