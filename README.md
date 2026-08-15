# skills

Agent skills I use daily. Written for [Claude Code](https://claude.com/claude-code), portable to any agent that reads `SKILL.md` files.

Each skill is a directory with a `SKILL.md` at its root. Nothing here is theoretical — a skill lands in this repo after it has survived real use.

## Skills

| Skill | Use it when |
| --- | --- |
| [writing-commits](writing-commits) | Drafting or rewording a commit message in a repo's own house style |

## Install

Clone into your personal skills directory:

```bash
git clone https://github.com/vishsant/skills.git ~/.claude/skills-vishsant
ln -s ~/.claude/skills-vishsant/writing-commits ~/.claude/skills/writing-commits
```

Or copy a single skill directory into `~/.claude/skills/` (user-wide) or `.claude/skills/` (per project).

## License

[MIT](LICENSE)
