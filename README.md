# skills

Agent skills I use daily. Built for real problems, not vibe coding.

Each skill is proven in production before it lands here. They work with [Claude Code](https://claude.com/claude-code), [Codex](https://github.com/copilot), [pi](https://pi.dev), and any agent that reads `SKILL.md` files.

## Skills

| Skill | Domain | Use it when |
| --- | --- | --- |
| [eng-writing-commits](https://github.com/vishsant/skills/tree/main/.agents/skills/eng-writing-commits) | Engineering | Drafting or rewording a commit message in a repo's own house style |

## Organization

Skills are organized by domain prefix in `.agents/skills/`:
- **`eng-*`** — engineering/code workflows (testing, reviews, commits)
- **`prod-*`** — productivity/process (grilling, research, planning)
- **`sys-*`** — systems/infrastructure (debugging, performance)
- **`write-*`** — writing/content (articles, documentation)

See [CONTRIBUTING.md](CONTRIBUTING.md) for how to add skills.

## Install

### Claude Code (Marketplace)

```bash
/plugin install vishsant-skills
```

Or from the command palette: `/plugin install vishsant-skills`

### Manual (Editable)

Clone into your personal skills directory:

```bash
git clone https://github.com/vishsant/skills.git ~/.claude/skills-vishsant
ln -s ~/.claude/skills-vishsant/.agents/skills/eng-writing-commits ~/.claude/skills/eng-writing-commits
```

Or copy a single skill directory into `~/.claude/skills/`:

```bash
cp -r .agents/skills/eng-writing-commits ~/.claude/skills/
```

## License

[MIT](LICENSE)
