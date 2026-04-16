# KF-02: Report Structure, Constraints & Section Content Frameworks

## Word and Page Budget

- Hard page limit: **≤100 pages (50 double-sided sheets)**, excluding appendices — this is the primary constraint
- Word count is not formally prescribed; the page limit is the binding constraint
- When producing or reviewing section drafts, estimate the word contribution as a rough guide, but flag sections primarily when they risk pushing the body over 100 pages.

## Appendix Policy

Large bulk material of **secondary importance** — including full program listings, complete data
tables, datasheets, and operation manuals — **must be relegated to the Appendices**, not embedded
in the body. Material to which the body text makes significant reference should be placed as close
as possible to the relevant text. When reviewing a draft, flag any material that should move to or
from the appendices.

---

## Required Report Structure

| # | Section | Status |
|---|---|---|
| 0 | Cover Sheet | [AUTO — optional, from `cover-sheet:` parameter] |
| 1 | Title Page | [AUTO — from `title:`, `author:`, `date:` parameters] |
| 2 | Abstract | [AUTO — content passed to `abstract:` parameter] |
| 3 | Acknowledgments | [AUTO — content passed to `acknowledgments:` parameter] |
| 4 | Table of Contents | [AUTO — `table-of-contents:` parameter] |
| 5 | List of Figures | [AUTO — `figure-index: (enabled: true)`] |
| 6 | List of Tables | [AUTO — `table-index: (enabled: true)`] |
| 7 | List of Listings | [AUTO — `listing-index: (enabled: true)`] |
| 8 | Abbreviations | [AUTO — `abbreviations: [#abbr.list()]`] |
| 9 | List of Symbols | [AUTO — content passed to `symbols:` parameter; required when a significant number of symbols are used] |
| 10 | Introduction | [BODY] |
| 11 | Analysis of Problem | [BODY] |
| 12 | Theoretical Principles | [BODY] |
| 13 | Method of Investigation | [BODY] |
| 14 | Design / Construction | [BODY] |
| 15 | Results | [BODY] |
| 16 | Discussion | [BODY] |
| 17 | Conclusion | [BODY] |
| 18 | References | [AUTO — from `bibliography:` parameter] |
| 19 | Appendices | [AUTO — content passed to `appendix.body`; numbered `A.1.1.` by default] |

---

## Section Content Frameworks

### Abstract

- **Length:** ≤200 words (hard limit).
- Passed to the `abstract:` parameter in the template header — **not** written as a body section with a heading.
- **Required 4-Move Structure:**
  1. **Context / Problem** — Motivate the work and state the objective clearly.
  2. **Methodology** — Summarise how the work was carried out.
  3. **Results** — Present major findings; include quantitative data where possible.
  4. **Conclusions / Implications** — State key interpretations and potential future applications.

---

### Introduction

**Required 6 Functions:**
1. Introduce the subject matter, the scope of the investigation, and the purpose of the project.
2. Provide a brief survey of previously published work and current trends, with IEEE-cited literature.
3. Define the technical problem or research gap.
4. Justify the importance and practical benefits of the proposed solution.
5. Outline the key deliverables.
6. Provide a roadmap of the remaining report structure.

---

### Theoretical Principles

- Establish all theoretical background and principles underpinning the design and results.
- Theory must **precede** the presentation of data and results that stem from it.
- Cite sources for all non-trivial theoretical claims, equations, and models.

---

### Method of Investigation / Design & Construction

#### Justifying Engineering Choices — Mandatory 3-Step Rule

Apply this rule to **every significant design or component selection decision**:

1. **Introduce** — State what decision or selection needed to be made.
   > *"A microcontroller was required to perform real-time signal acquisition and processing."*

2. **Describe** — State what was chosen or implemented, including relevant specifications.
   > *"The STM32F4 was selected, offering a 168 MHz Cortex-M4 core, a 12-bit ADC, and hardware floating-point support."*

3. **Comment / Justify** — Explain why this option was chosen over alternatives, supported by
   datasheets, standards, or literature.
   > *"This device was preferred over the [ALTERNATIVE] due to its higher clock frequency and
   integrated FPU, which are necessary to meet the real-time processing deadline of [X] ms @datasheet2022."*

---

### Results

**Reporting Results — Mandatory 3-Step Rule:**

1. **Introduce** — State what result or measurement is being examined.
2. **Describe** — Present what the data or figure shows, with an explicit callout reference
   (e.g., `@tbl:measured-output` or `@fig:frequency-response`).
3. **Comment** — Interpret what this means in the engineering context of the project.

**Hedging requirement:** Use cautious, evidential language throughout:
*suggests, indicates, appears to, may, could, is likely, probably.*
Never state interpretations as absolute fact.

---

### Discussion

**Mandatory 5 Components — all must be present:**

1. **Comparison with theory** — Explicitly compare observations and results with theoretical
   predictions. Where agreement is found, confirm it; where discrepancy exists, propose a
   reasoned engineering explanation.

2. **Cost-effectiveness assessment** — Evaluate the cost-effectiveness of the design and/or
   implementation. Consider component costs, development effort, performance delivered per unit
   cost, and alternatives considered.

3. **Practicality evaluation** — Assess practical viability: deployability, scalability, real-world
   constraints, power requirements, and how effectively the implementation addresses the original problem.

4. **Difficulties & Mitigation** — Articulate difficulties encountered, their impact on the work,
   mitigation strategies applied, and recommendations for avoiding similar issues in future work.

5. **Critical evaluation** — Critically evaluate the techniques employed and results obtained with
   appropriate engineering rigour; do not merely repeat the Results section.

**Hedging requirement:** Apply hedging language consistently throughout.

---

### Conclusion

**Required 5 Components:**
1. **Context** — Restate the objectives and briefly summarise the actions taken.
2. **Summary of Findings** — Summarise the major results; all conclusions must follow logically
   from the argument and results presented in the body.
3. **Significance** — Discuss the contribution to the field or practical engineering relevance.
4. **Limitations** — Acknowledge remaining gaps or weaknesses honestly.
5. **Recommendations** — Suggest future research directions or engineering development steps.

⚠️ **Do not introduce any new technical information in the Conclusion.**

---

### List of Symbols

- Include when the report uses a significant number of mathematical or engineering symbols.
- **Rendered automatically** by the `ilm` template via the `symbols:` parameter — do *not* write a "List of Symbols" body section. Pass a content block (typically a `#table` with two columns: Symbol, Definition) to the parameter; the template adds the heading.
- All symbols and units must conform to the **International System of Units (SI)** and **British Standards Institution (BSI)** recommendations.
- Each symbol must be defined at first use in the body text, consistent with its entry in the list.
- See `report-typst-syntax.md` for the template-header invocation and the inner table format.