---
name: audit-commit
description: Scan a staged diff for credentials, keys, and sensitive files before a commit lands. Use before git commit, or when asked to audit or check a diff for leaks.
---

# Audit Commit

A leak that reaches a commit is nearly impossible to fully undo — history rewrites don't reach forks or clones already pulled. So the check runs **before** the commit, on the staged diff, not after.

## Step 1 — Scan the staged diff

```bash
git diff --cached
git diff --cached --name-only
```

Check both the content and the file list. A leak hides in either: a key pasted into a line, or a whole file that should never be tracked.

Look for:

- **Sensitive filenames** — `.env`, `.env.*` (except `.env.example`/`.env.sample`), `*.pem`, `*.key`, `id_rsa*`, `credentials.json`, `*.p12`, `*.keystore`, service-account JSON.
- **Credential-shaped strings** — `AKIA[0-9A-Z]{16}` (AWS), `sk-[a-zA-Z0-9]{20,}` (API keys), `ghp_`/`gho_`/`github_pat_` (GitHub tokens), private key headers (`-----BEGIN...PRIVATE KEY-----`), JWTs (`eyJ` followed by base64 segments), connection strings with embedded passwords (`://user:pass@host`).
- **Assignment patterns** — `password=`, `secret=`, `token=`, `api_key=` followed by a literal value rather than an env-var reference (`os.environ`, `process.env`, `${...}`) or a placeholder (`xxx`, `changeme`, `<redacted>`).

## Step 2 — Classify each hit

- **Confirmed leak** — a filename or string above matches and is clearly live (not a fixture, not an obviously fake placeholder). Stop. Report the file and line. Do not commit. Suggest `git restore --staged <file>` or removing the line before the user retries.
- **In doubt** — matches the shape but context is ambiguous (test fixture directory, an obfuscated example, a value that could be a placeholder). Stop. Report what triggered the match and ask the user to confirm it's safe before proceeding.
- **Clean** — no matches. Proceed; nothing to report.

Never commit past a confirmed leak or an unresolved doubt, even if the rest of the diff is ready.

Done when every file in `git diff --cached --name-only` and every added line has been checked against Step 1's patterns, and each hit is classified.
