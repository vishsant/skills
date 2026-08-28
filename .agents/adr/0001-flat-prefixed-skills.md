# ADR 0001: Flat, Prefixed Skill Organization

**Status:** Superseded by [ADR 0002](0002-bucketed-skill-organization.md)  
**Date:** 2026-08-15  
**Author:** Vishnu Santhosh

> Superseded on 2026-08-28. The prefix never reached the agent (harnesses flatten skills, and frontmatter `name` was already unprefixed), and the flat layout gave the week-long real-use gate nowhere to happen. See [ADR 0002](0002-bucketed-skill-organization.md).

## Context

We need a skill repository structure that:
- Scales from 1 to 50+ skills without refactoring
- Works across harnesses (Claude Code, Codex, pi)
- Makes domain/category discoverable without deep folder nesting
- Reduces friction for adding new skills

## Decision

Use **Pattern 3: Flat directory with prefixed names**.

All skills live in `.agents/skills/` at the same level. Each skill name is prefixed with its domain:
- `eng-*` for engineering/code
- `prod-*` for productivity/workflow
- `sys-*` for systems/infrastructure
- `write-*` for writing/content

Example:
```
.agents/skills/
├── eng-writing-commits/
├── eng-tdd/
├── eng-code-review/
├── prod-grilling/
├── prod-research/
└── sys-debugging-bmc/
```

## Rationale

| Aspect | Flat+Prefix | Hierarchical | Flat only |
|--------|-------------|--------------|-----------|
| Simplicity | ✅ High | Medium | ✅ Highest |
| Scaleability | ✅ Linear | O(n²) refactoring | ✅ Linear |
| Discoverability | ✅ Naming | Folder browsing | Loose |
| Portability | ✅ Works everywhere | Good | ✅ Works everywhere |
| Naming discipline | ⚠️ Required | Optional | ⚠️ Required |

**Flat+Prefix wins** because it combines simplicity (flat structure) with organization (prefixes as semantic metadata). Prefixes are self-documenting and machine-readable.

## Constraints & Enforcement

- Skill directories **must** match regex: `^[a-z]+-[a-z0-9\-]+$` (e.g., `eng-tdd`, `prod-grilling`)
- Prefixes are domain identifiers; they are not namespaces
- A skill can address multiple domains if needed (e.g., `eng-prod-grilling` for cross-domain)
- All skills follow the same `.agents/skills/<prefix>-<name>/SKILL.md` path

Enforcement: CONTRIBUTING.md + optional GitHub Actions lint

## Alternatives Rejected

### Hierarchical (`skills/engineering/`, `skills/productivity/`)
- Pros: Clear visual organization
- Cons: Adds nesting depth; refactoring required when domains grow/merge

### Flat (no prefix)
- Pros: Simplest
- Cons: No semantic metadata; requires external tagging or careful README maintenance

## Future Decisions

If 50+ skills accumulate and prefixes become unwieldy, this can be revisited. For now, prefix-based organization is future-proof and simple.

**Outcome:** revisited at 1 skill, not 50. The trigger was not prefix unwieldiness but the missing lifecycle stage described in ADR 0002.
