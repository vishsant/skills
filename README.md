# skills

Agent skills I use daily. Built for real problems, not vibe coding.

Each skill is proven in production before it lands here. They work with [Claude Code](https://claude.com/claude-code), [Codex](https://github.com/copilot), [pi](https://pi.dev), and any agent that reads `SKILL.md` files.

## Skills

| Skill | Domain | Use it when |
| --- | --- | --- |
| [writing-commits](skills/engineering/writing-commits/SKILL.md) | Engineering | Drafting or rewording a commit message in a repo's own house style |

Also in the repo but not shipped: [in-progress](skills/in-progress/README.md) skills, public so they can be used and critiqued while they earn their place.

## Organization

Skills live in bucket folders under `skills/`:

- **`engineering/`** — daily code work (testing, reviews, commits)
- **`productivity/`** — daily non-code workflow (learning, planning, research)
- **`misc/`** — kept around, rarely used
- **`in-progress/`** — beta: public on purpose, not shipped in the plugin
- **`deprecated/`** — no longer used

The first two are **promoted**: the table above and the Claude Code plugin ship exactly that set. See [ADR 0002](.agents/adr/0002-bucketed-skill-organization.md) for why, and [CONTRIBUTING.md](CONTRIBUTING.md) for how to add skills.

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
ln -s ~/.claude/skills-vishsant/skills/engineering/writing-commits ~/.claude/skills/writing-commits
```

Or copy a single skill directory into `~/.claude/skills/`:

```bash
cp -r skills/engineering/writing-commits ~/.claude/skills/
```

This is also the only route to the `in-progress` skills, which the plugin deliberately excludes.

## License

[MIT](LICENSE)
