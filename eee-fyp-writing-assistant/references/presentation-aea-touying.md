# Presentation Mode — Touying + Assertion-Evidence Approach (AEA)

This reference produces a single ready-to-compile **Touying Typst (`.typ`) file** that
encodes:

1. **Slide content** — AEA assertion headlines + minimal body text / visual placeholder comments
2. **Spoken script** — embedded as `#speaker-note[...]` blocks with delivery cues, signposting, and the 3-step visual introduction method
3. **Q&A prep block** — appended as a commented section at the bottom (not rendered as slides)

After generating, always compile and verify the file compiles without errors.

---

## Step 0 — Gather Input

Accept either:
- **Free-form prompt** — e.g. "My FYP is about X, please make slides"
- **Report / abstract / paper text** — extract structure, key findings, and metrics automatically

If the user provides report or paper text, extract:
- Project title, author name (if mentioned)
- Problem / motivation
- Objectives (1–3 specific goals)
- Methodology / design decisions
- Key results with concrete numbers
- Conclusions and future work

If critical information is missing (title, key result numbers), ask before generating.

---

## Step 1 — Plan Slide Structure

Map content to this standard FYP structure. Adjust slide count to the user's time limit
(default: ~10 min = 10–12 content slides):

| Slide | Section | AEA Assertion Pattern |
|---|---|---|
| 1 | Title | (no assertion — just title, author, date, institution) |
| 2 | Motivation / Problem | [Problem domain] poses [challenge], creating a critical need for [solution type] |
| 3 | Research Gap | Existing approaches lack [X], leaving [specific gap] unaddressed |
| 4 | Objectives | This project addresses [gap] by [method], targeting [measurable goal] |
| 5–6 | Background / Related Work | [Prior approach] falls short because [limitation] |
| 7–8 | Methodology / System Design | [Design choice] is adopted for its [key advantage] over alternatives |
| 9–10 | Results | [System/model] achieves [metric] under [condition], [confirming/exceeding] the target |
| 11 | Discussion / Implications | [Finding] suggests [broader implication] for [application domain] |
| 12 | Conclusion | This project demonstrates [outcome], contributing [1–2 key novelties] |
| 13 | Q&A | (no assertion — just "Thank you. Questions?" + contact) |

---

## Step 2 — Apply AEA Principles to Each Slide

### Principle 1 — Assertion, Not Topic
- Headline = one complete sentence stating the key message
- Max 1–2 lines; use nominalisation to compress:
  - Wordy: "We changed the design and it got faster"
  - Nominalised: "Architectural redesign yields a [X]% latency reduction"
- One assertion per slide. One idea. No exceptions.

### Principle 2 — Visual over Bullets
- Body of each slide = `// [VISUAL: describe what figure/graph/diagram goes here]` comment
- If listing is unavoidable (e.g. 3 objectives), use 4 or fewer short keyword items, not sentences
- Never use full sentences in the slide body

### Principle 3 — Spontaneous Speech via Speaker Notes
- `#speaker-note[...]` = full rehearsal script, not a word-for-word recitation
- Include signposting, the 3-step visual intro, and delivery cues (see Step 3)

---

## Step 3 — Speaker Note Conventions

### Signposting Phrases

Use full reference phrases, not bare "next":

| Situation | Example phrase |
|---|---|
| Opening | "Good [morning/afternoon]. My name is [X]. Today I will present my FYP on [title]." |
| After outline | "Let me begin with the motivation behind this project." |
| New section | "Now that I have covered [X], let me turn to [Y]." |
| Recap before results | "Having outlined the methodology, I will now present the key findings." |
| Closing | "To summarise, this project has demonstrated [core message]." |
| Opening Q&A | "I will now open the floor for any questions." |

### 3-Step Visual Introduction

Every slide with a figure/graph/table must follow:

1. "This [figure/graph/table] shows [title/context]."
2. "On the x-axis we have [X]; on the y-axis, [Y]. [Colour/line] represents [Z]."
3. "The key finding here is [observation], which [confirms/suggests] [link to objective]."

### Delivery Cues

Embed inline in notes as comments:

- `// [PAUSE]` — after a key finding; let audience absorb
- `// [SLOW DOWN]` — before a technical term or critical number
- `// [POINT TO VISUAL]` — direct attention to a specific element
- `// [EYE CONTACT]` — look up at audience, not at slides

---

## Step 4 — Generate the Touying `.typ` File

Use the **`university`** theme (professional, academic) by default.
Use `metropolis` if the user wants a cleaner, minimal look.

### File Template

```typst
#import "@preview/touying:0.7.1": *
#import themes.university: *

#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Presentation Title],
    subtitle: [EEE Final Year Project],
    author: [Author Name],
    date: datetime.today(),
    institution: [Department of EEE],
  ),
)

// ─── Title Slide ────────────────────────────────────────────────────────────
#title-slide()

// ─── Outline ────────────────────────────────────────────────────────────────
== Outline
#components.adaptive-columns(outline(title: none, indent: 1em))
```

### Per-Slide Pattern

```typst
// ─── Section: [Name] ────────────────────────────────────────────────────────
= [Section Name]

== [Assertion: complete sentence stating the ONE key message]
// [VISUAL: description of figure/diagram/graph to place here]

- keyword or value 1
- keyword or value 2

#speaker-note[
  // [Signpost transition if moving to a new section]
  // 3-step visual intro
  // Key explanation with delivery cues inline as comments
  // Link back to research objective
]
```

### Section Dividers

- Use `= Section Name` (single `=`) to generate automatic section title slides.
- Use `== Slide Title` (double `==`) for individual slides within a section.

### Incremental Reveal (use sparingly for key result comparisons)

```typst
== Three candidate models balance accuracy and energy efficiency
- Model A #pause
- Model B #pause
- Model C
```

---

## Step 5 — Compile and Verify

After generating the `.typ` file, compile it:

```bash
typst compile presentation.typ
```

Fix any errors before presenting to the user. Common issues:

- Missing `#` before Touying function calls like `#speaker-note`, `#pause`, `#title-slide()`
- Unclosed `[` brackets in content blocks
- `datetime.today()` takes no arguments in Typst
- `outline()` inside `adaptive-columns` requires `title: none` to suppress duplicate heading

---

## Step 6 — Q&A Prep Block

Append this as a comment block at the bottom of the `.typ` file (not a slide):

```typst
// ════════════════════════════════════════════════════════════════════════════
// Q&A PREPARATION — for presenter reference only, not rendered as slides
// ════════════════════════════════════════════════════════════════════════════
//
// LIKELY QUESTIONS BY SECTION:
//
// Motivation:
//   Q: Why is this problem important now?
//   A: [fill in]
//
// Methodology:
//   Q: Why did you choose [method X] over [alternative Y]?
//   A: [fill in]
//   Q: What are the limitations of this approach?
//   A: [fill in]
//
// Results:
//   Q: Could you elaborate on [specific result]?
//   A: [fill in]
//   Q: What are the implications of these findings?
//   A: [fill in]
//
// Conclusion:
//   Q: What future work would you recommend?
//   A: [fill in]
//
// RESPONSE FRAMEWORK:
//   Acknowledge first: "That's a great question, thank you."
//   Answer directly, then stop.
//   If uncertain:  "We don't have data on that specifically, but based on
//                   [X] we would expect [Y]. I can follow up after the session."
//   Buy time:      "Let me take a moment. [Repeat the question back.]"
```

Generate topic-specific questions from the user's actual content — do not leave them generic.

---

## Nominalisation Quick Reference

| Casual / Spoken | Nominalised (for assertions) |
|---|---|
| "We showed the system works better" | "[System] performance improvement is demonstrated" |
| "The accuracy went up by X%" | "A [X]% accuracy gain is achieved over the baseline" |
| "Because the design is simpler, it uses less power" | "Design simplification enables [X]% power reduction" |
| "We tested it under different conditions" | "Robustness under varied operating conditions is confirmed" |
| "Our method is faster than other methods" | "The proposed method achieves superior throughput over baselines" |

---

## Output Checklist

- [ ] Every content slide has exactly **one assertion** (complete sentence headline)
- [ ] No slide body contains full sentences — keywords/values only
- [ ] Every slide with a figure has a `// [VISUAL: ...]` placeholder comment
- [ ] Every figure is introduced in speaker notes via the 3-step method
- [ ] Signposting phrases appear at every section transition in speaker notes
- [ ] Delivery cues are present in speaker notes
- [ ] Q&A prep block appended at the bottom with topic-specific questions
- [ ] File compiles without errors (`typst compile presentation.typ`)
- [ ] Output `.typ` file is presented to the user
