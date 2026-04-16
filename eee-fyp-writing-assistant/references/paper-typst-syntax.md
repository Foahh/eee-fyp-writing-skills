# Paper Typst Environment & Syntax Reference

## Writing Environment

The user writes their technical paper in **Typst** using a locally modified IEEE
template at `assets/ieee/lib.typ`. The template implements a single canonical style
(no `format` parameter); all drafted content must be compatible with it.

| Component | Details |
|---|---|
| Document template | `assets/ieee/lib.typ` (`ieee(...)`) |
| Code listings | `codly` v1.3.0 + `codly-languages` v0.1.1 (only if short snippets are essential) |
| Abbreviations | `@preview/abbr:0.3.0` — loaded from `assets/abbreviations.csv` |
| IEEE-style tables | `@preview/akatable:0.1.0` (`academic-table` with `format: "ieee"`) |
| Bibliography | `assets/reference.bib`, IEEE style via `bibliography(...)` |
| Typography | 11 pt body (Times New Roman), tight spacing (0.35 em) |
| Page | A4, 2 columns, gutter 14.4 pt, margins 54 pt (x and top), 72 pt (bottom) |
| Language | English (`#set text(lang: "en")`) |

### Template Header

```typst
#import "assets/ieee/lib.typ": ieee
#import "@preview/akatable:0.1.0": academic-table
#import "@preview/abbr:0.3.0"

#show: abbr.show-rule
#abbr.load("assets/abbreviations.csv")
#abbr.config(style: it => text(black, it))

#show: ieee.with(
  title: [Your Paper Title Here],
  authors: (
    (
      name: "Author Name",
      organization: [The University of Hong Kong],
      email: "author@connect.hku.hk",
    ),
  ),
  abstract: [Your abstract text here...],
  index-terms: ("Term A", "Term B", "Term C", "Term D"),
  bibliography: bibliography("assets/reference.bib", style: "ieee"),
)
```

### Template-Provided Style (Built-In)

| Property | Value |
|---|---|
| L1 heading numbering | Roman: I, II, III (smallcaps, centred, **bold**) |
| L2 heading numbering | Letter: A, B, C (italic) |
| L3 heading numbering | `1)` (run-in, italic) |
| L4+ heading | Italic run-in; no numbering |
| `Acknowledgment` heading | Detected by body text; rendered unnumbered, centred, smallcaps |
| Figure numbering | Arabic: 1, 2, 3 (caption **below**, smallcaps, centred) |
| Figure supplement | "Figure" (configurable via `figure-supplement:` parameter) |
| Table numbering | Roman: I, II, III; rendered as `TABLE I` (caption **above**, smallcaps, centred) |
| Equation numbering | Sequential `(1)`, `(2)`, … |
| Title block | Auto-rendered at the top, spans both columns (`scope: "parent"`) |
| Abstract | `_Abstract_ - <text>` followed by `_Index Terms_ - <list>` |
| Index terms label | "Index Terms" (override via `index-label:` parameter) |
| Ordered lists | `enum(numbering: "1)a)i)")` |
| Bibliography | IEEE style, 10 pt, title "References" |

> Title block, authors, abstract, and index terms are all rendered by the template from
> its parameters. **Do not duplicate them in body content.**

---

## Typst Syntax Reference

### Headings

```typst
= Section Heading          // Level 1 → "I.", "II.", ... (smallcaps, bold, centred)
== Subsection Heading      // Level 2 → "A.", "B.", ... (italic)
=== Subsubsection Heading  // Level 3 → "1)", "2)", ... (italic run-in; use sparingly)
```

The first paragraph after each heading is unindented; subsequent paragraphs are indented
by 18 pt (handled automatically by the template).

### Text Formatting

```typst
*bold text*
_italic text_
`inline code`
```

### Cross-References & IEEE Citations

```typst
@fig:system-overview       // → "Figure 1"
@tbl:results-summary       // → "Table I"
@eq:transfer-function      // → "(3)"

@smith2021                 // → [1]
@smith2021[p.~45]          // → [1, p. 45]
@smith2021 @jones2020      // → [1], [2]
```

When citing in the middle of a sentence, refer to "(1)", not "Eq. (1)" or "Equation (1)"
(except at the start of a sentence). Cross-reference sections inline as `Section II` or
`Section III-C`.

### Figures

```typst
#figure(
  image("assets/figures/block-diagram.png", width: 100%),
  caption: [Block diagram of the proposed signal processing pipeline.],
) <fig:block-diagram>
```

**Paper-specific notes:**
- One-column figures use `width: 100%` inside the column (~3.4 in physical width).
- For a figure that must span both columns or float to the top of the page, wrap in a
  parent-scope `#place(...)`:

```typst
#place(
  top + center,
  scope: "parent",
  float: true,
)[
  #figure(
    image("assets/figures/wide-plot.png", width: 75%),
    caption: [Cross-architecture benchmark.],
  ) <fig:wide-plot>
]
```

- Always reference the figure in body text *before* it appears.
- At two-column scale, axis labels, legends, line weights, and annotations must remain
  legible at the printed size.

### Tables — Use `academic-table` (akatable) for IEEE Style

The IEEE-style table renderer is `academic-table` from `@preview/akatable:0.1.0` with
`format: "ieee"`. **Prefer this over a raw `#figure(table(...))`** for any paper table —
it produces the canonical IEEE booktabs-style horizontal rules and inherits the
template's `TABLE I` numbering and top-aligned caption.

```typst
#academic-table(
  [Summary of system operating parameters.],   // caption (positional)
  header: ([Parameter], [Value], [Unit]),
  (
    [Supply Voltage], [3.3],  [V],
    [Sampling Rate],  [1000], [Hz],
    [Resolution],     [12],   [bit],
  ),
  columns: (auto, 1fr, auto),
  align: (left, right, left),
  format: "ieee",
  label: <tbl:system-params>,
)
```

For a wide table that must span both columns, wrap in `#place(...)`:

```typst
#place(
  top + center,
  scope: "parent",
  float: true,
)[
  #academic-table(
    [Cross-architecture benchmark for representative variants.],
    header: ([Model], [Res.], [mAP (%)], [Inf. (ms)], [E (mJ)]),
    (
      [TinyissimoYOLO v8], [320], [55.9], [18.7], [18.1],
      [ST-YOLODv2 Milli],  [256], [67.1], [25.6], [29.8],
      // ...
    ),
    columns: (auto, auto, auto, auto, auto),
    align: (left, right, right, right, right),
    format: "ieee",
    label: <tbl:benchmark>,
  )
]
```

`academic-table` parameters used in practice:

| Parameter | Purpose |
|---|---|
| 1st positional | Caption content |
| `header:` | Tuple of header cells |
| 2nd positional | Body cells, in row-major order, comma-separated |
| `columns:` | Column widths (`auto`, `1fr`, fixed lengths) |
| `align:` | Per-column alignment tuple (`left`, `right`, `center`) |
| `format:` | `"ieee"` for this template |
| `label:` | The cross-reference label (e.g. `<tbl:foo>`) |

Use `#linebreak()` inside cells to wrap header labels or long cell values. Use
`#super[$dagger$]` and `#super[$dagger.double$]` for footnote markers in cells, and
explain them in the caption.

### Equations

```typst
// Block (display) equation with label
$ H(s) = frac(omega_n^2, s^2 + 2 zeta omega_n s + omega_n^2) $ <eq:second-order>

// Inline equation
The closed-loop gain $A_v = -g_m R_D$ is set by the drain resistance.
```

Equations are numbered sequentially `(1), (2), …` and right-aligned. Equation references
resolve to the bare number, e.g. `@eq:pavg` → `(1)`.

### Code Listings

In a technical paper, **avoid full code listings**. Use only short, critical snippets
where the code itself is a contribution. If needed:

```typst
#figure(
  raw(lang: "python", read("assets/code/fft.py")),
  caption: [Python function for normalised FFT computation.],
) <lst:fft-function>
```

### Abbreviations (`abbr` v0.3.0)

```typst
// In body text:
The output of the @ADC is passed to the @MCU for processing.
// First occurrence → "Analogue-to-Digital Converter (ADC)"
// Subsequent       → "ADC"

// CSV format — assets/abbreviations.csv:
// ADC,Analogue-to-Digital Converter
// MCU,Microcontroller Unit,Microcontroller Units
```

⚠️ **When an abbreviation is immediately followed by `-` or `@`, escape the
punctuation** so the `abbr` package terminates the lookup at the right boundary. See the
dedicated rule and table in `common-language-style.md` (section "Abbreviation Token
Boundary"). Examples actually used in the reference paper:
`@NPU\-equipped`, `@COCO\-Person`, `@mAP\@0.5`, `@YOLO\-family`, `@GAP9\-based`.

### Ordered Lists

The template configures `enum(numbering: "1)a)i)")`, so ordered lists render as `1)`,
`a)`, `i)` at the three nesting levels. Use the standard Typst `+` syntax:

```typst
+ First item
  + Nested
    + Deeply nested
+ Second item
```

### Graphics Quality Requirements

- Monochrome graphics: 600 dpi
- Grayscale graphics: 300 dpi
- Colour graphics: 300 dpi
- No raw screenshots — use clean vector diagrams, properly exported plots, or formatted outputs.
- Save each graphic as a separate file and insert via `image()`.
