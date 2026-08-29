# Contributing Skills

Before a skill ships, it must pass two gates:

1. **Real use** — used in production for at least a week. Document the use case.
2. **Tight spec** — narrow, solves one problem well. No "I might need this someday."

A skill that hasn't cleared gate 1 isn't rejected, it's just **not promoted yet**: it lives in `skills/in-progress/`, public and usable, but absent from the README and the plugin. That is where the week actually happens.

## Layout

```
skills/
├── engineering/   # daily code work            (promoted)
├── productivity/  # daily non-code workflow    (promoted)
├── misc/          # kept around, rarely used
├── in-progress/   # beta, not shipped
└── deprecated/    # no longer used
```

Rationale: [ADR 0002](.agents/adr/0002-bucketed-skill-organization.md).

## Naming

- Directory matches `^[a-z0-9][a-z0-9\-]*$`, unprefixed: `writing-commits`, `learn-it`
- Frontmatter `name` equals the directory name
- **Names must be globally unique.** Harnesses flatten every skill into one directory, so a collision means one skill silently shadows another. Check this repo, check `~/.claude/skills`, and search the ecosystem before you settle on a name. `scripts/link-skills.sh` fails loudly on in-repo duplicates, but it cannot see skills from other sources.

## Adding a Skill

### 1. Create the directory

```bash
mkdir -p skills/in-progress/my-skill
```

### 2. Write SKILL.md

`SKILL.md` is the only required file.

```yaml
---
name: my-skill
description: One sentence. Use it when X.
---
```

Add `disable-model-invocation: true` if the skill should be reachable only by the human. See [AGENTS.md](AGENTS.md#invocation) for which kind to pick.

Content guidelines:

- Keep it short. Under 2000 words for most skills, and under 800 if you can.
- Write instructions, not essays. An agent reading it should know what to do next at every point.
- Self-contained. Link external docs sparingly.
- Give procedural steps a **done when** condition, so the agent can tell whether it finished.

### 3. Add agents/openai.yaml

```yaml
interface:
  display_name: "My Skill"
  short_description: "What it does"
```

For a user-invoked skill, also:

```yaml
policy:
  allow_implicit_invocation: false
```

### 4. List it

Add a row to `skills/in-progress/README.md`.

### 5. Test it in isolation

```bash
./run.sh
```

Launches `pi` scoped to only this repo's skills (excluding `deprecated/`) — no interference from other skills installed globally. Rebuilds `.agents/skills` from the repo on every run, so don't author anything directly in `.agents/skills`; it's a disposable view of `skills/`.

### 6. Use it for real

```bash
scripts/link-skills.sh
```

This symlinks every non-deprecated skill into `~/.claude/skills` and `~/.agents/skills`. Edits in the repo take effect immediately.

## Promoting a Skill

After a week of real use:

- [ ] `git mv skills/in-progress/<name> skills/<bucket>/<name>`
- [ ] Row moved from `skills/in-progress/README.md` to the bucket's `README.md`
- [ ] Row added to the top-level `README.md`
- [ ] Path added to `.claude-plugin/plugin.json`'s `skills` array
- [ ] `claude plugin validate . --strict` passes
- [ ] `scripts/link-skills.sh` re-run

## Design Principles

- **Tight scope** — one job, done well
- **Self-contained** — no external docs required
- **Real use** — you use it, not hypothetical
- **Portable** — works on Claude Code, Codex, pi, any agent that reads `SKILL.md`

Portability is a constraint on *content*, not just packaging: a skill that depends on one harness's custom tools isn't portable. Express what you need as a capability, and give a fallback for harnesses that lack it.

If your skill is doing too much, split it.
