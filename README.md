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

Two ways in. **The Claude Code plugin** installs the whole set as a managed bundle that updates when I ship. **`npx skills`** copies editable skill files into your project, so you can hack on them. Pick one — installing both leaves you with every skill twice.

### Claude Code (plugin)

This repo isn't in Claude Code's official marketplace, so add it first:

```bash
/plugin marketplace add vishsant/skills
/plugin install vishsant-skills@vishsant
```

### Codex, and other agents

```bash
npx skills@latest add vishsant/skills
```

### Manual (editable)

Symlink a skill so edits in the repo take effect immediately:

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
