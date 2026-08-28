# MISSION.md format

Why the user wants this topic. Everything else in the workspace is judged against it: what to probe, what to teach next, what to leave out.

A mission is not a syllabus. "Learn Rust" is a topic, not a mission. "Ship a CLI tool I can hand to my team without it segfaulting" is a mission, because it tells you that ownership and error handling matter and that async does not, yet.

Write it after interrogating the user, never from a one-line request. Confirm before changing it later.

```markdown
# Mission: <topic>

## What I want to be able to do

<The capability, stated as something the user could actually do or judge.
Concrete enough that you can tell whether a given lesson serves it.>

## Why now

<What prompted this. A project, a decision, a conversation they could not
follow. This is what makes teaching feel relevant rather than academic.>

## What done looks like

<The observable end state. If they would not know when to stop, the mission
is still too vague.>

## Explicitly not this

<Adjacent things the user does not want. Guards against scope drift, and is
usually the fastest way to sharpen a vague mission.>

## Constraints

<Time available, prior commitments, deadline, preferred depth. Omit if none.>
```

## Revising it

Missions move as the user learns, and that is normal, not a failure. When it moves:

1. Confirm with the user before editing.
2. Update `MISSION.md`.
3. Record the change in `MAP.md` under Mission history, with the date and what changed.

A silently rewritten mission makes the existing map unreadable, since nobody can tell which nodes were chosen under which goal.
