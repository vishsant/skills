---
name: writing-commits
description: Commit messages written in a repo's own house style. Use before git commit, or when drafting or amending a message.
---

# Writing Commits

A commit message is accepted when it looks like it was written by the people already committing to the repo. So the **house style** — that repo's observed conventions — outranks any general rule of good commit writing. Infer it from evidence every time; repos differ, and your memory of this repo is stale.

## Step 1 — Read the house style, then name the convention

Stage the change first — the third command reads staged paths. Run all three. Cheap, and each answers a different question.

```bash
git log --no-merges -50 --format='%s'                                       # subject conventions
git log --no-merges -12 --format='%B%n--8<--'                               # body conventions
git log --no-merges -20 --format='%s' -- $(git diff --cached --name-only)   # subsystem-local prefixes
```

Sampling is asymmetric on purpose: subjects are one line so take many, bodies are expensive so take few. When most of those 12 carry no body, body-less **is** the house style for small changes — check whether the ones that do have bodies are the larger diffs.

**Declared style beats inferred style.** Read whichever of these exist, and follow them where they conflict with the log: `CONTRIBUTING.md`, `.gitmessage`, `commitlint.config.*`, `.commitlintrc*`, `.github/PULL_REQUEST_TEMPLATE.md`.

**No usable history** — a fresh repo, or all three commands come back empty — means there is no house style to infer. Say so, and go straight to the fallback below instead of inventing a convention from a handful of commits.

State each slot to yourself before writing a word of the message:

- **Prefix scheme** — Conventional Commits type(scope), subsystem name, ticket key, or none
- **Casing** after the prefix, and whether the subject ends in a period
- **Mood** — imperative ("add") or past ("added")
- **Subject ceiling** — the longest subject in the sample, not a textbook number
- **Body** — present always, only for non-trivial changes, or never
- **Body content** — why the change was needed, or what it does
- **Body shape** — prose paragraphs or bullets, and the wrap width
- **Trailers and refs** — `Refs #12`, `Closes #12`, `Co-authored-by`, ticket URLs, sign-off

Where the sample is genuinely split, follow the most recent commits — conventions drift forward.

**Fallback**, for slots the sample leaves undecided, or when there is no usable history at all: imperative subject ≤50 chars with no trailing period, blank line, body wrapped at 72 explaining why over what.

Done when every slot above is filled from a named source — a declared file, an observed majority, or the fallback.

## Step 2 — Write it against the staged diff

Read `git diff --cached` and describe what is actually staged — not the whole session's work, and not the plan you were following.

The body's job is the reasoning a reader cannot recover from the diff: the constraint that forced this design, the alternative rejected, the bug the change fixes. When diagnosis preceded the fix, the confirmed cause belongs here.

Commit multi-line messages by passing a file, so the body survives shell quoting:

```bash
git commit -F <path>
```

**A rejected or rewritten commit means a hook caught something real.** Read its output and fix the message; don't reach for `--no-verify`.

Done when the message fills every slot named in Step 1, and its claims match the staged diff.

## When the diff resists one message

A staged diff spanning unrelated changes produces a vague subject — the message is the symptom, the staging is the cause. Say so, and propose the split as separate commits.
