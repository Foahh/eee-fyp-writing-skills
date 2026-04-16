# Report Typst Environment & Syntax Reference

## Writing Environment

The user writes their report in **Typst** using a locally modified `ilm` template at
`assets/ilm/lib.typ`. All drafted content must be compatible with it.

| Component | Details |
|---|---|
| Document template | `assets/ilm/lib.typ` (`ilm(...)`) |
| Code listings | `codly` v1.3.0 + `codly-languages` v0.1.1 (auto-styled fenced blocks) |
| Abbreviations | `@preview/abbr:0.3.0` — loaded from `assets/abbreviations.csv` |
| Bibliography | `assets/reference.bib`, IEEE style via `bibliography(...)` parameter |
| Typography | Times New Roman / Liberation Serif / Nimbus Roman; size set by `body-size:` parameter |
| Page | A4 (configurable via `paper-size:`); margin defaults inherited from Typst |
| Language | English (`#set text(lang: "en", region: "GB")`) |

---

## What the `ilm` Template Generates Automatically

The following are produced by the template's parameters and **must not be written as
body sections** — pass content to the parameter instead.

| Front-matter element | Source parameter | Notes |
|---|---|---|
| Cover Sheet | `cover-sheet: (enabled: true, body: [...])` | Optional; renders as page 1, no number |
| Title Page | `title:`, `author:`, `date:` | Always rendered when those parameters are set |
| Abstract | `abstract: [...]` | Content block; appears as a heading-1 page |
| Acknowledgments | `acknowledgments: [...]` | Content block; appears as a heading-1 page |
| Table of Contents | `table-of-contents: outline()` | Auto-generated from headings |
| List of Figures | `figure-index: (enabled: true, title: "...")` | Generated from `<fig:...>` labels |
| List of Tables | `table-index: (enabled: true, title: "...")` | Generated from `<tbl:...>` labels |
| List of Listings | `listing-index: (enabled: true, title: "...")` | Generated from `<lst:...>` labels |
| Abbreviations List | `abbreviations: [#abbr.list()]` | Rendered with custom heading and table styling |
| **List of Symbols** | `symbols: [<table content>]` | Rendered as a heading-1 page titled "List of Symbols" |
| References / Bibliography | `bibliography: bibliography("assets/reference.bib", style: "ieee")` | IEEE style |
| Appendix | `appendix: (enabled: true, title: "...", body: [...])` | Numbered `A.1.1.` by default |

**Front-matter pages use Roman page numbering (`i, ii, …`); the main body restarts at
`1`.** A running footer in the main matter shows the current chapter title and page.

### Template Header

```typst
#import "assets/ilm/lib.typ": ilm
#import "@preview/abbr:0.3.0"

#show: abbr.show-rule
#abbr.load("assets/abbreviations.csv")
#abbr.config(style: it => text(black, it))

#show: ilm.with(
  title: [Project Title],
  author: "Author Name",
  date: datetime(year: 2026, month: 4, day: 18),
  abstract: [Abstract text…],
  acknowledgments: [Acknowledgments text…],
  abbreviations: [#abbr.list()],
  symbols: [
    #table(
      columns: (auto, 1fr),
      table.header([Symbol], [Definition]),
      [$omega_n$], [Natural frequency (rad/s)],
      [$zeta$],    [Damping ratio (dimensionless)],
      [$V_"CC"$],  [Supply voltage (V)],
    )
  ],
  bibliography: bibliography("assets/reference.bib", style: "ieee"),
  appendix: (enabled: true, title: "Appendices", body: [
    = Appendix Section
    Appendix content...
  ]),
)
```

## What the User Writes (Body)

All body content from **Introduction** through to the **Conclusion** (and any appendix
content passed to `appendix.body`). Acknowledgments, abstract, lists of figures/tables,
and the List of Symbols are passed via parameters and must NOT be written as body
sections.

---

## Typst Syntax Reference

### Headings & Page Breaks

```typst
= Section Heading          // Level 1 — appears in TOC and running footer
== Subsection Heading      // Level 2
=== Subsubsection Heading  // Level 3

#pagebreak()               // Explicit page break (use sparingly)
```

Heading numbering is decimal (`1.`, `1.1`, `1.1.1`).

### Text Formatting

```typst
*bold text*
_italic text_
`inline code`
```

### Cross-References & IEEE Citations

```typst
@fig:system-overview       // → "Figure 1"
@tbl:results-summary       // → "Table 2"
@eq:transfer-function      // → "(3)"

@smith2021                 // → [1]
@smith2021[p.~45]          // → [1, p. 45]
@smith2021 @jones2020      // → [1], [2]
```

### Figures

```typst
#figure(
  image("assets/figures/block-diagram.png", width: 80%),
  caption: [Block diagram of the proposed signal processing pipeline.],
) <fig:block-diagram>
```

Figure captions appear **below** the figure. Always reference the figure in body text
*before* it appears: e.g. *"@fig:block-diagram shows..."*.

### Tables

The `ilm` template applies a default style: light grey 0.5 pt strokes, 7 pt cell inset,
small-caps first row.

```typst
#figure(
  table(
    columns: (auto, 1fr, auto),
    table.header([Parameter], [Value], [Unit]),
    [Supply Voltage],  [3.3],   [V],
    [Sampling Rate],   [1000],  [Hz],
    [Resolution],      [12],    [bit],
  ),
  caption: [Summary of system operating parameters.],
) <tbl:system-params>
```

**Table captions appear *below* the table** (Typst default; not overridden by the local
`ilm`). If the user explicitly wants captions above, add a show rule:

```typst
#show figure.where(kind: table): set figure.caption(position: top)
```

### Equations

```typst
// Block (display) equation with label
$ H(s) = frac(omega_n^2, s^2 + 2 zeta omega_n s + omega_n^2) $ <eq:second-order>

// Inline equation
The closed-loop gain $A_v = -g_m R_D$ is set by the drain resistance.
```

Equations are numbered sequentially `(1), (2), …`.

### Code Listings (Codly)

```typst
// Codly auto-styles fenced raw blocks with language icons and names.
// To add a caption and label, wrap in #figure():
#figure(
  raw(lang: "python", read("assets/code/fft.py")),
  caption: [Python function for normalised FFT computation.],
) <lst:fft-function>
```

Full program listings belong in the Appendices, not the body. Reference them with
`@lst:label`.

### Abbreviations (`abbr` v0.3.0)

With `#show: abbr.show-rule` active, abbreviations expand automatically on first use.

```typst
// In body text:
The output of the @ADC is passed to the @MCU for processing.
// First occurrence → "Analogue-to-Digital Converter (ADC)"
// Subsequent       → "ADC"

// Plural form specifier:
The @GPIO:pla are configured as outputs.
// → "General-Purpose Input/Output pins (GPIOs)" on first use

// CSV format — assets/abbreviations.csv:
// ADC,Analogue-to-Digital Converter
// MCU,Microcontroller Unit,Microcontroller Units
// GPIO,General-Purpose Input/Output,General-Purpose Input/Output pins
```

⚠️ **When an abbreviation is immediately followed by `-` or `@`, escape the
punctuation** so the `abbr` package terminates the lookup at the right boundary. See the
dedicated rule and table in `common-language-style.md` (section "Abbreviation Token
Boundary"). Examples: `@NPU\-equipped`, `@COCO\-Person`, `@mAP\@0.5`.

### List of Symbols

The List of Symbols is **rendered automatically** by the `ilm` template when the
`symbols:` parameter is provided in the template header. **Do not write a "List of
Symbols" body section** — pass a content block (typically a `#table`) to `symbols:`
instead. See the template header example above.

The page heading "List of Symbols" is added by the template (heading-1, unnumbered,
outlined). Inside the content block, only the table itself (or any other symbol-listing
content) is needed.
