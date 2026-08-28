# AGENTS.md

You're in a skills repository. Before you do anything, read this.

## What This Repo Is

A collection of agent skills I use in production. Each skill solves one real problem. Nothing here is theoretical.

## Structure

Skills live in bucket folders under `skills/`:

- `engineering/` — daily code work
- `productivity/` — daily non-code workflow
- `misc/` — kept around, rarely used
- `in-progress/` — beta: public on purpose, feedback wanted, not shipped
- `deprecated/` — no longer used

`engineering/` and `productivity/` are the **promoted** buckets. Why buckets rather than the flat prefixed layout this repo started with: [ADR 0002](.agents/adr/0002-bucketed-skill-organization.md).

Buckets are repo organization only. Every harness flattens skills into one directory, so **skill names must be unique repo-wide** — and worth checking against the ecosystem too, since `~/.claude/skills` holds skills from every source at once.

## The Promotion Rule

Every skill in a promoted bucket **must** have a row in the top-level `README.md` and an entry in `.claude-plugin/plugin.json`'s `skills` array. The plugin ships exactly the promoted set.

Skills in `misc/`, `in-progress/`, and `deprecated/` **must not** appear in either.

Each bucket has a `README.md` listing its skills, with the skill name linked to its `SKILL.md`.

Run `claude plugin validate . --strict` after touching `plugin.json` or `marketplace.json`.

## Before You Add a Skill

1. **Real use** — used in production for at least a week. Until it clears that bar it belongs in `in-progress/`, not a promoted bucket.
2. **Tight scope** — solves one problem well. No "might be useful someday."
3. **Unique name** — no collision inside this repo or with skills already installed.

See [CONTRIBUTING.md](CONTRIBUTING.md) for the full process.

## Adding a Skill

1. Create `skills/in-progress/<name>/`
2. Write `SKILL.md`: YAML frontmatter (`name` matching the directory, `description`) plus markdown
3. Add `agents/openai.yaml`
4. Add a row to `skills/in-progress/README.md`
5. Link it locally and use it: `scripts/link-skills.sh`

## Promoting a Skill

Once it has earned it:

1. `git mv skills/in-progress/<name> skills/<bucket>/<name>`
2. Move its row from `skills/in-progress/README.md` to the bucket's `README.md`
3. Add a row to the top-level `README.md`
4. Add its path to `.claude-plugin/plugin.json`'s `skills` array
5. Re-run `scripts/link-skills.sh`

## Invocation

Every `SKILL.md` is one of two kinds, and the choice is deliberate:

- **User-invoked** — `disable-model-invocation: true` in the frontmatter plus `policy.allow_implicit_invocation: false` in `agents/openai.yaml`. Reachable only by the human. Use this when the skill has side effects the user should choose: writing to a workspace, prompting for a path, starting something stateful.
- **Model-invoked** — no such keys. The agent triggers it from the `description`, so write the description as a trigger condition ("Use when...").
