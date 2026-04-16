# Common Language & Style Standards, Visual Integration, and Citations

These rules apply to **report** and **paper** modes. Mode-specific addenda are clearly
marked. (Presentation mode has its own conventions in `presentation-aea-touying.md`.)

## Voice

Use **third-person passive voice** predominantly, especially in Methodology and Design sections.

✅ *"The microcontroller was programmed to..."*
✅ *"The filter coefficients were computed using..."*
❌ Avoid first-person pronouns (*I, we, our*).

> **Report-only exception:** First-person may be required for explicitly personal
> reflection content (e.g. "lessons learnt"). Do not use first-person elsewhere.

> **Paper:** No standard exception — first-person is not used unless the user explicitly
> requests it.

---

## Tense Rules

| Tense | When to Use |
|---|---|
| **Present** | General background knowledge, working principles, EEE theory, reference to figures or data, current industry standards |
| **Past** | Completed tasks, specific experimental or design actions, recorded observations and measurements |
| **Future** | Proposed actions, recommendations, and suggested future work |

---

## Tone & Register

Maintain a **formal, objective, academic** engineering tone throughout.

**Never use:**
- Contractions (*don't, it's, can't*)
- Rhetorical questions
- Promotional or marketing language (*cutting-edge, revolutionary, state-of-the-art* used without citation)
- Colloquialisms or informal phrasing
- "For the ___, it is ___" constructions
- Excessive use of "which" and "would"

---

## Concision

> **Paper-critical addendum:** In a 9–12 page paper, every word must earn its place.
> Apply these principles aggressively; in a report, apply them with judgement.

- Eliminate redundant phrases: "in order to" → "to"; "due to the fact that" → "because"; "it is worth noting that" → delete or rephrase.
- Avoid paragraph-level mini-introductions and mini-conclusions that are common in reports. In a paper, shorter paragraphs and compact section headings carry the structure.
- Prefer active constructions where they are shorter and clearer, while maintaining academic register.
- Cut any sentence that does not advance the argument, present data, or provide necessary context.

---

## Audience Accommodation

Briefly define specialised sub-domain EEE terminology (e.g. a specific IC peripheral, a
niche DSP algorithm, a proprietary communication protocol) when it may not be universally
familiar across the broader EEE discipline. A one-sentence micro-explanation is usually
enough.

This does not mean "explain everything from scratch" — assume EEE competence. It means
flagging and briefly glossing terms that are specific to a narrow sub-field.

> **Paper-critical addendum:** A technical paper targets a broader audience than a report
> (researchers, scholars, and professionals from various EEE disciplines). Apply this
> rule more aggressively than in a report.

---

## Symbols and Units

- All symbols and units must conform to the **International System of Units (SI)** and **British Standards Institution (BSI)** recommendations.
- Define every symbol explicitly at its first occurrence in the body text.
- Do not mix unit systems (e.g. SI with imperial or CGS) without explicit justification.

> **Report-only addendum:** If a symbol appears in the List of Symbols, its body text
> definition must be consistent with that list entry.

---

## Cohesion & Clarity

- Prefer clear, concise declarative sentences. Avoid long, convoluted constructions.
- Use explicit cohesive devices:
  - Sequential: *first, subsequently, finally, thereafter*
  - Causal: *therefore, consequently, as a result, hence*
  - Contrastive: *however, nevertheless, in contrast, conversely*
- Ensure coherence across sections — each section should logically follow from the previous one, and the reader should never be surprised by the direction of the argument.

---

## Visual Integration Rules

### General Rules

- All figures and tables receive automatic sequential numbering from Typst when a `<label>` is applied to the `#figure()` call.
- Figure captions appear **below** the figure in both templates.
- No raw screenshots. All visuals must be clean vector diagrams, properly exported simulation plots, schematic captures, or formatted measurement outputs.

**Table caption position differs by template:**

| Template | Mode | Table caption position | How |
|---|---|---|---|
| `ieee` | paper | **Above** the table | Set by template (`set figure.caption(position: top)` for `kind: table`) |
| `ilm` | report | **Below** the table | Typst default; no override in the local `ilm` template |

When drafting report tables, accept the default below position unless the user
explicitly asks for above (in which case add a show rule).

### Paper-Specific Visual Constraints

> Applies to **paper** mode only.

- Figures and tables must fit within **one column** (~3.4 in) or **two columns** (~7 in).
- At paper scale, visuals are much smaller than in a report. Ensure:
  - Axis labels and tick marks are readable at the printed size.
  - Legends are legible and not overlapping data.
  - Annotations and callouts are clear.
  - Line weights are sufficient to be visible.
- Figure/table positions may be less strictly near their associated text due to column-layout constraints, but make a reasonable effort to optimise proximity.
- Use figures and tables to **summarise information economically** — a well-designed figure can replace multiple paragraphs of text.

### Mandatory 3-Step Integration Rule

**Never insert a figure or table without all three steps:**

1. **Callout** — Reference the label in body text *before* the visual appears.
   > *"The overall system architecture is illustrated in @fig:block-diagram."*
   > *"@tbl:system-params summarises the operating parameters."*

2. **Describe** — Explain what the visual shows in the surrounding text.

3. **Comment** — Discuss its significance to the findings or design argument.

> **Paper-critical addendum:** Because paper paragraphs are shorter, the describe and
> comment steps can be more compact than in a report — but they must still be present.

---

## Citations & References

- Use **IEEE** citation style throughout, rendered automatically by the `bibliography:` parameter in the active Typst template.
- In body text, cite using `@bibtex_key`. The key must correspond to a valid entry in `assets/reference.bib`.
- All factual claims, background theory, sourced equations, standards, and borrowed material **must be cited**.
- Visuals taken or adapted from external sources must be cited in their caption.

### Fabrication Rule

⚠️ **Never fabricate, invent, or guess BibTeX keys, author names, paper titles, journal
names, DOIs, or publication years.** If a citation is needed but not yet provided by the
user, flag it with an inline comment at the exact point in the Typst output:

```typst
// ⚠️ CITATION NEEDED — [brief description of the claim requiring a source]
```

### Abbreviation Flag Format

When a new abbreviation is introduced in drafted content that was **not already present**
in the user's provided text or draft, place the following comment immediately before its
first use:

```typst
// ⚠️ ADD TO abbreviations.csv: SHORT, Full Long Form
```

Never flag abbreviations already present in the user's own material — these are assumed
to exist in `assets/abbreviations.csv`.

### Abbreviation Token Boundary — Escape Trailing Punctuation

The `abbr` package looks up the longest possible token after `@` until a whitespace or
non-word character. Any **hyphen, `@`, or other punctuation that should *not* be part of
the lookup key** must be escaped with a backslash (`\`) so the package terminates the
key correctly. This is mandatory whenever an abbreviation appears in a compound or
adjacent to another `@`-key.

| ❌ Wrong (parsed as one key) | ✅ Correct (key + escaped punctuation) |
|---|---|
| `@ToF-based` | `@ToF\-based` |
| `@NPU-equipped` | `@NPU\-equipped` |
| `@COCO-Person` | `@COCO\-Person` |
| `@YOLO-family` | `@YOLO\-family` |
| `@mAP@0.5` | `@mAP\@0.5` |
| `@COCO-style` | `@COCO\-style` |
| `@GAP9-based` | `@GAP9\-based` |

The `\` in Typst escapes the next character so it is rendered literally and not consumed
by the preceding markup token. Without the escape, the `abbr` lookup will fail (or, in
the worst case, silently treat `ToF-based` as an undefined abbreviation key).

When drafting Typst that introduces such compounds, always escape the boundary
character. When reviewing a user's draft, flag any unescaped `@KEY-word` or `@KEY@…`
patterns as bugs.
