---
name: learn-it
description: Teach a topic across sessions so it locks in as understanding, not memorized facts.
disable-model-invocation: true
argument-hint: "What do you want to learn?"
---

# Learn It

Two brains can hold the same facts and answer the same questions. One holds a pile of disconnected facts; the other holds a few core truths the rest are derivable from. That connection **is** understanding. Memorized facts rot. Understood facts hold each other in place.

The target is a **dependency graph** in their head: roots they accept at face value, every other node visibly resting on the ones below it.

The mechanism: **the brain commits only to facts it is sure are safe to lock in.** If something more fundamental might later contradict it, committing is risky, so the brain hedges and the fact never lands. Both principles remove that risk, and every step below serves them.

## Principle 1 — Unconditional truths first

Start from ground the user can accept **as-is, with no caveats**. Not because bottom-up is logically tidy, but because caveat-free facts are the easiest thing for a brain to commit to. They are safe, so they lock in instantly and give you something solid to build from.

If a candidate truth needs conditions, it is not one yet. Dig down further.

Reach for these two shapes wherever the domain has a clean one:

- **Universal statements** — "all X are Y", "no X is Y". Nothing to hedge against. Strongest in atomic-unit form, *"ALL X happens through {____}"*: "ALL communication between computers is done through **sending packets**."
- **Real definitions** — an actual definition, not properties dressed up as one. "Things that tend to be true of X" anchors nothing.

Where the domain has neither, take the smallest genuinely caveat-free ground you can find: small and solid beats large and shaky.

**Terminology.** An *unconditional truth* is accepted without caveats; an *axiom* follows from nothing else. Plenty of unconditional truths do derive from deeper things, so say "unconditional truth" unless the fact genuinely bottoms out.

## Principle 2 — "How could I have discovered this?"

Facts feel arbitrary when there is no visible reason they had to be this way, and the brain will not commit to arbitrary-feeling information. So make every fact feel **discovered, not decreed**.

Motivate every step, the intermediate ones included. Why are we doing this at all? What problem sends us down this path? Why reach for *this* formula, *this* move, *this* abstraction? Nothing appears from nowhere. 3Blue1Brown is the reference standard.

Choose per stretch: **Socratic**, posing the motivating problem and letting them attempt it before you reveal, which is more effortful and locks in harder; or **expository**, narrating the discovery path yourself when the topic is beyond cold reasoning or they are low on energy. Default Socratic whenever they could plausibly reason their way there.

## The workspace

Learning is stateful, so it lives in a directory that persists across sessions:

```
<workspace>/
├── MISSION.md          why they want this
├── MAP.md              the dependency graph and where the frontier sits
├── NOTES.md            how they want to be taught
└── lessons/
    └── 0001-<slug>.md  one markdown lesson per session
```

**Write the teaching into the lesson file as you go.** It is the artifact; chat carries the probing, the questions, and the steering. Markdown means LaTeX and mermaid render in any decent viewer.

**Ephemeral mode.** The user can run the whole thing in the session instead: the same four documents in the same formats, written as chat messages rather than files, gone when the session closes. Every instruction below that names a file applies unchanged to its in-session counterpart, and nothing touches disk. Post them in full when they change, since a document the user can scroll back to is the only memory the run has.

`MAP.md` is what makes a later session cheap: read it and you know the **frontier**, so you probe at the edge instead of re-teaching the middle. Every phase below writes to it, so read [MAP-FORMAT.md](MAP-FORMAT.md) for its shape and the `solid` / `shaky` / `planned` vocabulary before Phase 1.

## Phase 0 — Open the workspace

**Default to ephemeral: don't ask where the workspace lives.** Use ephemeral unless the user's request already names a workspace path or asks to persist the learning, in which case use that instead.

- **Ephemeral (default)** — say plainly that this session's learning ends with the session, then establish the mission exactly as for a new workspace.
- **Existing workspace** — read `MISSION.md`, `MAP.md`, `NOTES.md`, and skim the latest lesson. Confirm the mission still holds, then probe at the frontier it records.
- **New workspace** — create it, then establish the mission before anything else. Interrogate until it is concrete: "I want to understand LLMs" means ten different things and each implies a different course. Ask what they want to be able to *do*, and what prompted it now, then write `MISSION.md` per [MISSION-FORMAT.md](MISSION-FORMAT.md).

Every later judgment about what to teach is made against the mission, which is what makes pinning it the highest-return minute in the session.

**Done when** `MISSION.md` holds a concrete mission the user has confirmed, the workspace mode (ephemeral or persisted) is settled, and, for an existing workspace, you have read the frontier `MAP.md` records.

## Phase 1 — Probe first

Teaching lands at the edge of someone's understanding, so find that edge before planning anything. Use graded questions (see [Asking graded questions](#asking-graded-questions)).

**An edge is located once it is bracketed.** For each strand the lesson will rest on, get both a **floor** (something at that level they answer right) and a **ceiling** (something they get wrong or genuinely do not know). The edge sits between them, and one side alone leaves it unlocated.

- **A clean run means escalate.** All-correct gives you a floor and no ceiling, so the questions were too easy. Jump the difficulty sharply until something breaks.
- **Binary-search the edge.** Escalate hard after a right answer; narrow back in after a wrong one.
- **Characterize every miss before drawing a conclusion.** One wrong answer is a single coordinate whose kind is still open: a slip, an isolated gap, or a systematic misconception. Probe around it. Misconceptions matter most, since a confidently held wrong model must be dislodged rather than topped up, so map its extent and record it in `MAP.md`.
- **Cover every strand the lesson depends on**, and stop at the ones it does not.

**Done when every goal-relevant strand is bracketed** — you can name both what they hold and where it runs out — and `MAP.md`'s Frontier and Misconceptions record it.

## Phase 2 — Plan

The highest-leverage phase: a good plan is what makes the teaching feel inevitable rather than arbitrary.

1. **Scope the field.** Research before planning: core concepts, genuine first principles, standard framings, common gotchas. Ground the plan in what you verify now rather than what you recall. Delegate to a subagent if the harness has one, otherwise search directly.
2. **Find the unconditional truths** this rests on. Is there a clean atomic unit?
3. **Start at their edge.** Build from exactly what Phase 1 showed they hold.
4. **Build the motivated path** from those truths to the mission. For each step, ask where it comes from and why anyone would reach for it.
5. **Stress-test the roots.** For each node you are treating as foundational, ask whether it is genuinely accepted at face value or a disguised theorem resting on something simpler. If it derives, push it down and extend the map. A wrong root corrupts everything above it, and roots are far easier to audit on paper than mid-lesson.

**Then present the plan in chat and stop.** Two parts:

- **The approach, in prose.** What you will cover, in what order, and why this way given their edge and their mission.
- **The dependency map** as a small ```mermaid``` `graph TD`: unconditional truths at the roots, the mission at the sink. Few nodes, short labels. This *is* the teaching order.

**Done when the user has approved the plan** — a wrong root is cheap to fix here and expensive mid-lesson — and `MAP.md` holds its nodes as `planned`. Then open the lesson file.

## Phase 3 — Teach (the loop)

Build the graph **one node at a time**. Every node runs the same four steps, foundations included:

1. **Motivate.** Why this node, right now? What gap does it close? Unconditional truths earn this too: motivate why *this* truth, *now*.
2. **Establish.** A foundation: state it plainly, no caveats, and check it reads as obviously true to them. A derived step: build it from what is already in place via a motivated move.
3. **Connect.** Make the dependency edge explicit. Show exactly what this hangs off. This is the step that converts a fact into understanding, and the one most often skipped.
4. **Check.** Confirm it landed with a graded question. A node earns `solid` in `MAP.md` only here; on a miss, mark it `shaky` and repair it before building on top.

Write each node into the lesson file as you complete it, and move its `MAP.md` status as you go.

Run all four steps on every node for the whole session, foundations included. When you catch yourself asserting something they would have to take on faith, stop and either motivate and confirm it, or ground it in something already established.

**Done when** every node taught this session is `solid` or explicitly `shaky`, `MAP.md`'s Frontier names where the edge now sits, and the lesson closes with what comes next. Record any stated teaching preferences in `NOTES.md` per [NOTES-FORMAT.md](NOTES-FORMAT.md).

## Asking graded questions

Graded questions carry Phase 1 and Phase 3. Every one has a known correct answer, and which wrong option they pick tells you *where* they went wrong rather than merely that they did.

**Use the harness's graded-question tool if it has one.** Otherwise use this protocol, which works anywhere:

1. Present the question with lettered options, plus **"I don't know"** as an explicit choice. It keeps a genuine gap distinguishable from a lucky guess.
2. **Withhold the correct answer and the explanation** until after they answer.
3. On their reply: mark it ✓ or ✗, give the correct answer, explain why.
4. One at a time, each adapted to the last answer. Many small graded questions beat one big caveated one.

### Constructing the options

The usual failure is that the correct option is guessable from its shape alone. Auditing afterwards does not catch this, because the tell was baked in before the audit ran. Build the options so evenness is automatic:

1. **Every option is a bare claim, with no justification anywhere.** The number one giveaway is the correct option carrying its own reasoning ("..., because it preserves ordering") while the distractors are bare, making it longer and more specific. Put zero "why" in any option. All reasoning goes in the explanation, after they answer.
2. **Write the correct claim first, then mutate it into each distractor.** Take a real misconception and state what someone holding it would claim, in the *same* skeleton, grain size, and register. Every option is then "the claim under some belief," and the correct one is just the claim under the correct belief. Parallelism falls out by construction instead of being policed.
3. **Each distractor is a real error they might actually make**, so which one they pick is diagnostic, yet unambiguously wrong on the intended reading. Tempting, not tricky.
4. **Format every option identically.** Bold the parallel term in all of them or in none, so formatting never singles out the answer.

If you can read the finished set cold and still tell which is right without knowing the material, you skipped step 1 or 2. Regenerate rather than patch.

## Accuracy is non-negotiable

The user has to be able to trust the teacher completely, and one confidently delivered hallucination poisons that. Working from memory is where models invent things.

**The moment you are even slightly unsure of a fact, name, date, formula, definition, or claim, stop and verify before you say it.** Use a research subagent if the harness has one, otherwise search. If it has neither, say plainly that the claim is unverified and mark it as uncertain.

Pausing to verify is always acceptable, and accuracy beats flow. If a check corrects what you were about to teach, say so rather than quietly papering over it.

## Visuals

Visualize when the idea is a structure or a geometry: a dependency graph, a system with parts and arrows, a flow, a sequence, a state machine, a tree, something spatial. A picture earns its place by showing what words cannot.

Write it as a ```mermaid``` block directly in the lesson file. One idea, fewest elements: for each element, ask whether deleting it loses the idea, and keep it only if it does. Cramming makes a diagram both harder to read and likelier to be wrong.

When prose or a single equation already carries the idea, leave it in prose. A diagram restating the sentence beside it adds noise and a chance to be wrong, so when in doubt, keep writing.

## Formatting

Lesson files are read rendered, so write all math as LaTeX: `$f(x) = x^2$` inline, `$$` fenced on its own lines for display.
