# ADR 0002: Bucketed Skill Organization

**Status:** Accepted
**Date:** 2026-08-28
**Author:** Vishnu Santhosh
**Supersedes:** [ADR 0001](0001-flat-prefixed-skills.md)

## Context

ADR 0001 chose flat directories with domain prefixes (`.agents/skills/eng-writing-commits/`). Two problems surfaced once the repo had a shipping process rather than a single skill.

**The prefix carried no weight.** Harnesses flatten skills into one namespace anyway, so the prefix never reached the agent — the frontmatter `name` did, and it was already unprefixed (`eng-writing-commits/` declares `name: writing-commits`). The prefix was a directory-naming convention that only humans ever read, and it forced every new domain into a taxonomy decision before the first skill in it existed.

**CONTRIBUTING.md required a week of production use before shipping, with nowhere to put a skill during that week.** The gate was unenforceable: a skill was either absent or fully shipped, so the only way to use one for a week was to ship it first.

## Decision

Organize skills into **bucket folders** under a top-level `skills/`, with unprefixed directory names:

```
skills/
├── engineering/   # daily code work
├── productivity/  # daily non-code workflow
├── misc/          # kept around, rarely used
├── in-progress/   # beta: public on purpose, not shipped
└── deprecated/    # no longer used
```

`engineering/` and `productivity/` are the **promoted** buckets. A skill is promoted when it has passed the real-use gate, and only promoted skills appear in `README.md` and `.claude-plugin/plugin.json`. Everything else is public in the repo but absent from the shipped plugin.

Buckets are repo organization only. Every harness flattens skills into a single directory, so **skill names must be globally unique** across the whole repo and, in practice, against the wider ecosystem.

## Rationale

- **The maturity ladder is the point.** `in-progress/` gives the week-long gate somewhere to happen. A skill lives there while it earns its place, then moves one directory to ship.
- **Buckets replace prefixes without losing anything.** The domain is still visible at a glance, but it is a directory you can rename or merge rather than a string baked into every skill's path.
- **Promotion becomes a single, checkable rule.** In a promoted bucket implies listed in `README.md` and `plugin.json`; anywhere else implies listed in neither. That is lintable; "used it for a week" was not.
- **Convergence with the ecosystem.** This mirrors [mattpocock/skills](https://github.com/mattpocock/skills), the layout most widely-installed skill repos already use, so contributors and tooling arrive knowing where things live.

The nesting-depth objection in ADR 0001 was real but small: one extra level, and it buys a lifecycle the flat layout could not express.

## Constraints & Enforcement

- Skill directories match `^[a-z0-9][a-z0-9\-]*$` and live at `skills/<bucket>/<name>/`
- Frontmatter `name` equals the directory name
- Skill names are unique repo-wide, and checked against the ecosystem before adoption
- Promoted (`engineering/`, `productivity/`) implies an entry in `README.md` and in `plugin.json`'s `skills` array
- Non-promoted (`misc/`, `in-progress/`, `deprecated/`) implies an entry in neither
- Each bucket except `deprecated/` carries a `README.md` listing its skills
- `scripts/link-skills.sh` symlinks every non-deprecated skill into `~/.claude/skills` and `~/.agents/skills`

## Alternatives Rejected

### Keep ADR 0001, add an `in-progress-` prefix
Encodes lifecycle in the skill's own name, so promoting a skill renames its directory *and* its frontmatter `name`, breaking every existing link and symlink. Buckets let a skill move without changing identity.

### Buckets with prefixes retained
Redundant. The bucket already states the domain, and the prefix would then have to agree with it or contradict it.

## Migration

`.agents/skills/eng-writing-commits/` moved to `skills/engineering/writing-commits/`. `.agents/` keeps the ADRs. No frontmatter changed, since names were already unprefixed.
