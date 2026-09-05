---
name: note-it-down
description: Take structured notes while consuming source material.
disable-model-invocation: true
argument-hint: "What are you watching / reading?"
---

# Note It Down

The user is consuming source material — a video, an article, documentation, a talk — and wants structured notes that survive the session. The agent is the scribe: it captures, organizes, and refines, but the user decides what is worth recording.

The artifact is a single Markdown file, organized into sections that read well cold: someone picking it up weeks later should find the key ideas, not a chat log.

## Phase 0 — Set up

Ask two things:

1. **What is the source?** Title, URL, author if known. This becomes the note header.
2. **Where should the note live?** A file path. Default to `notes/<slugified-title>.md` in the current working directory if they don't have a preference.

Create the file with the header:

```markdown
# <Title>

**Source:** <URL or description>
**Date:** <today>

---
```

**Done when** the file exists with its header and the user is ready to begin.

## Phase 1 — Capture (the loop)

The user feeds material: quotes, timestamps, observations, questions, reactions, or just "note this." The agent's job on each input:

1. **Extract the idea.** Distill what the user said or quoted into a clean, self-contained statement. Not a summary of their words — the underlying point they are capturing.
2. **Place it.** Decide which section it belongs in, creating sections as the structure emerges. Sections are by theme or topic, not by chronology. Move earlier notes between sections when a better grouping becomes clear.
3. **Write it.** Append to the file immediately. Each note is a bullet or short paragraph under its section heading. Keep the user's emphasis and framing; don't flatten their voice into generic summary language.

Between inputs, stay quiet. No prompting, no "what's next," no summaries unless asked. The user is consuming; interruptions break flow.

**When the user asks a question about the material**, answer it and note both the question and the answer if the exchange surfaces something worth keeping.

**When the user reacts** ("this is wrong," "interesting," "disagree"), capture the reaction alongside the idea it's reacting to. Reactions are signal; they mark what mattered.

**Done when** the user signals they are finished or moves on.

## Phase 2 — Finalize

When the session ends:

1. **Re-read the full note.** Reorder sections so the most important themes lead. Merge any sections that turned out to be the same idea under different names.
2. **Add a summary.** Three to five sentences at the top, below the header, capturing the throughline: what was the source about, and what did the user take from it.
3. **Present the final note** in chat and confirm the file is written.

**Done when** the user has seen the final artifact and has no further changes.

## Principles

- **Fidelity over polish.** A note that captures what the user actually thought beats a clean one that smooths it away. Keep their words when they chose them carefully.
- **Structure emerges, not imposed.** Don't pick sections up front. Let the material reveal its shape, then organize around it.
- **Silence is default.** The user is watching or reading. The agent writes, not talks.
