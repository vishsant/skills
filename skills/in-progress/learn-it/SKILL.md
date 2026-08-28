---
name: learn-it
description: Teach the user a topic so it locks in as understanding rather than memorized facts, across sessions. Use when they want to learn something, or to resume something they are already learning.
disable-model-invocation: true
argument-hint: "What do you want to learn?"
---

# Learn It

Two brains can hold the same facts and answer the same questions. One holds a pile of disconnected facts; the other holds a few core truths the rest are derivable from. That connection **is** understanding. Memorized facts rot. Understood facts hold each other in place.

So the goal is never "they can recite it." It is a **dependency graph** in their head: roots they accept at face value, every other node visibly resting on the ones below it.

The mechanism: **the brain will not commit to a fact it is not sure is safe to lock in.** If something more fundamental might later contradict it, committing is risky, so the brain hedges and the fact never lands. Both principles remove that risk, and every step below serves them.

## Principle 1 — Unconditional truths first

Start from ground the user can accept **as-is, with no caveats**. Not because bottom-up is logically tidy, but because caveat-free facts are the easiest thing for a brain to commit to. They are safe, so they lock in instantly and give you something solid to build from.

If a candidate truth needs conditions, it is not one yet. Dig down further.

Two especially strong shapes, neither to be forced where the domain has no clean one:

- **Universal statements** — "all X are Y", "no X is Y". Nothing to hedge against. Strongest in atomic-unit form, *"ALL X happens through {____}"*: "ALL communication between computers is done through **sending packets**."
- **Real definitions** — an actual definition, not properties dressed up as one. "Things that tend to be true of X" anchors nothing.

Small and solid beats large and shaky.

**Terminology.** An *unconditional truth* is accepted without caveats; an *axiom* follows from nothing else. Not synonyms, since plenty of unconditional truths do derive from deeper things. Say "unconditional truth" unless the fact genuinely bottoms out.

## Principle 2 — "How could I have discovered this?"

Facts feel arbitrary when there is no visible reason they had to be this way, and the brain will not commit to arbitrary-feeling information. So make every fact feel **discovered, not decreed**.

Motivate every step, the intermediate ones included. Why are we doing this at all? What problem sends us down this path? Why reach for *this* formula, *this* move, *this* abstraction? Nothing appears from nowhere. 3Blue1Brown is the reference standard.

Choose per stretch: **Socratic**, posing the motivating problem and letting them attempt it before you reveal, which is more effortful and locks in harder; or **expository**, narrating the discovery path yourself when the topic is beyond cold reasoning or they are low on energy. Default Socratic whenever they could plausibly reason their way there.

## The workspace

Learning is stateful. The workspace is a directory that persists across sessions:

```
<workspace>/
├── MISSION.md          why they want this — see MISSION-FORMAT.md
├── MAP.md              the dependency graph and where the frontier sits — see MAP-FORMAT.md
├── NOTES.md            how they want to be taught — see NOTES-FORMAT.md
└── lessons/
    └── 0001-<slug>.md  one markdown lesson per session
```

Formats: [MISSION-FORMAT.md](MISSION-FORMAT.md), [MAP-FORMAT.md](MAP-FORMAT.md), [NOTES-FORMAT.md](NOTES-FORMAT.md).

**The lesson file is the artifact, not a transcript.** Write the teaching into it as you go, and use chat for probing, questions, and steering. Markdown means LaTeX and mermaid render in any decent viewer.

`MAP.md` is what makes a later session cheap: read it and you know the frontier, so you probe at the edge instead of re-teaching the middle.

## Phase 0 — Open the workspace

**Ask the user where the workspace is.** Never assume the current directory: this skill is invoked from wherever they happen to be, and the learning lives somewhere fixed. Default to `~/learning/<topic-slug>/`, and offer it rather than silently using it.

- **Existing workspace** — read `MISSION.md`, `MAP.md`, `NOTES.md`, and skim the latest lesson. Confirm the mission still holds, then probe **only at the frontier**, not from scratch.
- **New workspace** — create it, then establish the mission before anything else. Interrogate until it is concrete: "I want to understand LLMs" means ten different things and each implies a different course. Ask what they want to be able to *do*, and what prompted it now. Write `MISSION.md` and confirm it.

Failing to pin the mission is the most expensive mistake available, since every later judgment about what to teach is made against it.

## Phase 1 — Probe (never skip)

You cannot teach into the edge of someone's understanding without finding that edge first. Use graded questions (see [Asking graded questions](#asking-graded-questions)).

**The edge is only located when it is bracketed.** For each strand the lesson will rest on, you need both a **floor** (something at that level they get right) and a **ceiling** (something they get wrong or genuinely do not know). The edge sits between them. One side alone tells you nothing.

- **All correct is not done.** It means the questions were too easy: a floor with no ceiling. Escalate hard until something breaks.
- **Binary-search it.** After a right answer, jump difficulty sharply. After a wrong one, narrow back in.
- **One wrong answer is not done either, and is not a cue to start teaching.** You do not know its kind yet: a slip, an isolated gap, or a systematic misconception. Probe around it. Misconceptions matter most, since a confidently held wrong model must be dislodged rather than topped up, so dig into its extent and record it in `MAP.md`.
- **Map every strand the lesson depends on**, and no corners it does not.

**Done when**, for each goal-relevant strand, you can state concretely both what they have and where it runs out. Update `MAP.md`'s Frontier and Misconceptions before moving on.

## Phase 2 — Plan (think hard here)

The highest-leverage step. Do not rush it.

1. **Scope the field.** Research before planning: core concepts, genuine first principles, standard framings, common gotchas. Do not plan around a half-remembered version. Delegate to a subagent if the harness has one, otherwise search directly.
2. **Find the unconditional truths** this rests on. Is there a clean atomic unit?
3. **Start from what they already hold.** Not below it, not above it.
4. **Build the motivated path** from those truths to the mission. For each step, ask where it comes from and why anyone would reach for it.
5. **Stress-test the roots.** For each node you are treating as foundational: genuinely accepted at face value, or a disguised theorem resting on something simpler? If it derives, push it down. A wrong root corrupts everything above it, and roots are far easier to audit on paper than mid-lesson.

**Then present the plan in chat and stop.** Two parts:

- **The approach, in prose.** What you will cover, in what order, and why this way given their edge and their mission.
- **The dependency map** as a small ```mermaid``` `graph TD`: unconditional truths at the roots, the mission at the sink. Few nodes, short labels. This *is* the teaching order.

Wait for their go-ahead. A wrong root is cheap to fix now and expensive mid-lesson. On approval, add the planned nodes to `MAP.md` as `planned` and open the lesson file.

## Phase 3 — Teach (the loop)

Build the graph **one node at a time**. Every node gets the full loop, foundations included:

1. **Motivate.** Why this node, right now? What gap does it close? Unconditional truths need this too: do not assert one just because it is true.
2. **Establish.** A foundation: state it plainly, no caveats, and check it reads as obviously true to them. A derived step: build it from what is already in place via a motivated move.
3. **Connect.** Make the dependency edge explicit. Show exactly what this hangs off. This is the step that converts a fact into understanding, and the one most often skipped.
4. **Check.** Confirm it landed with a graded question. If they miss it, mark the node `shaky` in `MAP.md` and fix it before building on top.

Write each node into the lesson file as you complete it, and update `MAP.md` statuses as you go rather than at the end.

Never front-load the foundations and then stop checking. If you catch yourself asserting something they would have to take on faith, stop: motivate and confirm it, or ground it in something already established.

**End the session** by updating `MAP.md` (statuses, Frontier, new misconceptions) and noting in the lesson what comes next. Add any stated teaching preferences to `NOTES.md`.

## Asking graded questions

Graded questions do the work in Phase 1 and Phase 3, so they matter more than any other mechanic here. Every one has a known correct answer, and which wrong option they pick tells you *where* they went wrong, not merely that they did.

**Use the harness's graded-question tool if it has one.** Otherwise use this protocol, which works anywhere:

1. Present the question with lettered options, plus **"I don't know"** as an explicit choice. Without it you get guesses that read as knowledge.
2. **Withhold the correct answer and the explanation** until after they answer.
3. On their reply: mark it ✓ or ✗, give the correct answer, explain why.
4. One at a time, each adapted to the last answer. Many small graded questions beat one big caveated one.

### Constructing the options

The usual failure is that the correct option is guessable from its shape alone. Auditing afterwards does not catch this, because the tell was baked in before the audit ran. Build the options so evenness is automatic:

1. **Every option is a bare claim, with no justification anywhere.** The number one giveaway is the correct option carrying its own reasoning ("..., because it preserves ordering") while the distractors are bare, making it longer and more specific. Put zero "why" in any option. All reasoning goes in the explanation, after they answer.
2. **Write the correct claim first, then mutate it into each distractor.** Take a real misconception and state what someone holding it would claim, in the *same* skeleton, grain size, and register. Every option is then "the claim under some belief," and the correct one is just the claim under the correct belief. Parallelism falls out by construction instead of being policed.
3. **Each distractor is a real error they might actually make**, so which one they pick is diagnostic, yet unambiguously wrong on the intended reading. Tempting, not tricky.
4. **No asymmetric formatting.** Do not bold the key term in the correct option only. Bold it in all of them or none.

If you can read the finished set cold and still tell which is right without knowing the material, you skipped step 1 or 2. Regenerate rather than patch.

## Accuracy is non-negotiable

The user has to be able to trust the teacher completely, and one confidently delivered hallucination poisons that. Working from memory is where models invent things.

**The moment you are even slightly unsure of a fact, name, date, formula, definition, or claim, stop and verify before you say it.** Use a research subagent if the harness has one, otherwise search. If it has neither, say plainly that you cannot verify and flag the claim as uncertain rather than asserting it.

Pausing to verify is always acceptable, and accuracy beats flow. If a check corrects what you were about to teach, say so rather than quietly papering over it.

## Visuals

A picture earns its place only when it shows something words cannot: structure, direction, relationship, geometry. Reach for one for a dependency graph, a system with parts and arrows, a flow, a sequence, a state machine, a tree, or something spatial.

Write it as a ```mermaid``` block directly in the lesson file. One idea, fewest elements: for each element, ask whether deleting it loses the idea, and if not, delete it. Cramming makes a diagram both harder to read and likelier to be wrong.

Do not visualize when prose or a single equation already carries it. A decorative diagram restating the sentence beside it adds noise and a chance to be wrong. When in doubt, leave it out.

## Formatting

Lesson files are read rendered, so write math as LaTeX: `$f(x) = x^2$` inline, `$$` fenced on its own lines for display. If LaTeX can be used, use it.
