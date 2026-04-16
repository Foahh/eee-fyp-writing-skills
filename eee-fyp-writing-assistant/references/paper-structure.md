# KF-02: Paper Structure, Page Budget & Section Content Frameworks

## Page Budget

- Target length: **9–12 pages** (two-column format, A4 paper).
- This is dramatically shorter than the ~100-page report. Every sentence must earn its
  place. Prioritise contributions, results, and significance over procedural detail.

### Approximate Page Allocation

| Section | Suggested Pages | Notes |
|---|---|---|
| Title + Author + Abstract + Index Terms | ~0.5 | Shares first page with Introduction |
| Introduction | ~1–1.5 | Background, objectives, motivation, paper overview |
| Related Work / Literature Review | ~1 | Only directly relevant studies; no exhaustive survey |
| Methodology / Approach / Design | ~1.5–2 | Condensed; omit routine procedures |
| Results and Discussion | ~3–4 | The core of the paper; foreground key findings |
| Conclusion | ~0.5–1 | Summarise, state significance, suggest future work |
| Acknowledgement | ~0.1 | Brief; before references |
| References | ~0.5–1 | IEEE format |

These are guidelines, not rigid rules. Adjust based on the project — a design-heavy
project may need more methodology space; a data-heavy project may need more results space.

---

## Required Paper Structure

| # | Section | Notes |
|---|---|---|
| 1 | Title | Concise, specific, and informative |
| 2 | Author & Affiliation | Name, institution, email |
| 3 | Abstract | ≤ 200 words; passed to template via `abstract:` parameter |
| 4 | Index Terms | ~4 terms, alphabetical; passed via `index-terms:` parameter |
| 5 | Introduction | Background, motivation, objectives, paper overview |
| 6 | Related Work / Literature Review | Focused on research gap; not exhaustive |
| 7 | Methodology / Approach / Design | Condensed from report; focus on what is novel |
| 8 | Results and Discussion | May be combined or separate; organised by topic, not chronology |
| 9 | Conclusion | Significance, limitations, future work |
| 10 | Acknowledgement | Before references |
| 11 | References | IEEE numbered style |

> **What to omit from the report:**
> - Exhaustive background/history — keep only studies directly related to the research gap
> - Step-by-step procedural narratives (unless the method itself is a contribution)
> - Personal reflections and "lessons learnt"
> - Full code listings, complete data tables, datasheets (no appendices in a paper)
> - Report roadmap paragraph (replace with a paper overview)
> - Separate Analysis of Problem, Theoretical Principles, Method, Design sections —
>   consolidate into fewer, tighter sections

---

## Section Content Frameworks

### Title

- Be specific and informative. A reader should understand the topic and scope from the title alone.
- Avoid vague titles like "FYP Report" or "Final Year Project."
- Good pattern: *"[Method/Approach] for [Problem/Application] Using [Key Technology]"*

---

### Abstract

The abstract is a self-contained summary of the entire paper. Write it last.

**Constraints:**
- One paragraph, **≤ 200 words** (hard limit).
- Followed immediately by Index Terms (~4 terms, alphabetical, comma-separated).
- No citations, no undefined abbreviations, no references to figures/tables/equations.

**Required 4-Move Structure:**
1. **Context / Problem** — State the problem domain and why this work matters (1–2 sentences).
2. **Objective / Approach** — State what was done and how (2–3 sentences).
3. **Key Results** — Present major quantitative findings (2–3 sentences). Include numbers.
4. **Significance / Implications** — State what the results mean and potential applications
   (1–2 sentences).

Every move must be present. The abstract should not contain citations, undefined
abbreviations, or references to figures/tables.

---

### Index Terms

- Place immediately after the abstract; the template renders them as `_Index Terms_ - …`.
- **~4 terms**, comma-separated, in **alphabetical order**.
- Passed to the template via the `index-terms:` parameter as a tuple of strings.
- Choose terms that identify the major topics: the application domain, key technologies,
  methods, and the type of contribution.

---

### Introduction

The introduction must accomplish these functions concisely (~1–1.5 pages):

1. **Open with the problem and objective.** The first sentence should state the objective
   concisely and indicate why it is important. Do not begin with broad historical context.
2. **Provide focused background.** Briefly introduce only the context necessary to
   understand the problem. Keep it to 1–2 paragraphs, not a full history.
3. **Identify the research gap.** What has previous work missed or left unsolved?
4. **State the contributions.** Explicitly list the novel contributions of this paper.
   What is new? Why does it matter?
5. **State the deliverables / objectives.** Be specific about what was achieved.
6. **Provide a paper overview.** One paragraph summarising the structure of the remaining
   sections — what each section covers.

> **A-range quality note:** The introduction should include interesting or novel points
> that encourage the reader to continue. Avoid generic, encyclopaedic openings.

---

### Related Work / Literature Review

- Much shorter than in the report. Select only the most relevant prior studies that
  directly relate to the research gap.
- For each cited work, state what it contributed and what limitation or gap remains.
- End the section by positioning your work relative to the gap.
- All claims about prior work must be cited with IEEE references.

---

### Methodology / Approach / Design

- Describe the approach at a level sufficient for the reader to understand and evaluate it,
  but omit routine procedural steps that are standard in the field.
- If the method itself is a novel contribution, give it more space; otherwise, condense.
- **Engineering choice justification** — For every significant design or component decision,
  apply the 3-step pattern:
  1. **Introduce** — State what decision needed to be made.
  2. **Describe** — State what was chosen, with relevant specifications.
  3. **Justify** — Explain why this option was chosen over alternatives.
- Use figures (block diagrams, schematics, flowcharts) to communicate system architecture
  efficiently. A well-labelled diagram can replace paragraphs of text.
- Equations for key models or derivations should be included and numbered.

---

### Results and Discussion

This is the core of the paper. It should receive the most space (~3–4 pages).

**Organisation:**
- Organise by **major topics or findings**, not chronologically.
- Results and Discussion may be combined into one section or kept separate — choose
  whichever produces better flow for the project.
- Use specific, informative subheadings (e.g., "Frequency Response Under Varying Load
  Conditions" rather than "Test Results").

**Reporting results — 3-step rule:**
1. **Introduce** — State what result or measurement is being examined.
2. **Describe** — Present the data, referencing the specific figure or table.
3. **Interpret** — Discuss what the result means. Is it expected, acceptable, or
   unexpected? How does it compare to theory or prior work? What are the implications?

**Hedging requirement:** Use cautious, evidential language:
*suggests, indicates, appears to, may, could, is likely.*
Never state interpretations as absolute fact.

**Foregrounding contributions:**
- Lead with the most important results — the ones that demonstrate the paper's
  contribution (hypothesis confirmed, technical target achieved, deliverable validated).
- Results should be supported by clear, well-captioned figures and tables.
- Where results deviate from expectations, provide a reasoned engineering explanation.

**Limitations:**
- Report major limitations and shortcomings as they arise from the interpretation of
  results. Unlike a report, do not include a separate reflective "lessons learnt" section.
- Frame limitations in terms of their impact on the results and what immediate future
  work they motivate.

---

### Conclusion

The conclusion should be concise (~0.5–1 page) and add a higher-level analysis beyond
what appeared in the Results section.

**Required components:**
1. **Restate objectives** — Briefly summarise what the paper set out to do.
2. **Summarise key findings** — State the major results. All conclusions must follow
   logically from the results presented in the paper.
3. **State significance** — Explicitly indicate the contribution to the field or
   practical engineering relevance. This is critical for A-range quality.
4. **Acknowledge limitations** — Briefly note remaining gaps or weaknesses.
5. **Suggest future work** — Propose concrete next steps or research directions.

⚠️ **Do not introduce any new technical information in the Conclusion.**

> **A-range quality note:** Avoid merely repeating the Results section. The Conclusion
> should synthesise and elevate, answering "so what?" and "what next?"

---

### Acknowledgement

- Place after the Conclusion, before References.
- Use the singular heading "Acknowledgement" (the template detects this and renders it unnumbered, centred, smallcaps).
- Thank supervisors, collaborators, funding sources, and anyone who provided significant
  assistance.
- Keep it brief — typically 2–4 sentences.

---

### References

- IEEE numbered citation style.
- Number references sequentially in the order they are first cited in the text.
- Use bracketed numbers: [1], [2], [3]–[5].
- Do not write "Ref. [3]" or "reference [3]" — just use the bracketed number.
- Reference text: 8 pt, full justified, hanging indent 0.25 in.
- Include all references cited in the text; do not include uncited references.
