#let std-bibliography = bibliography
#let std-smallcaps = smallcaps
#let std-upper = upper

#let smallcaps(body) = std-smallcaps(text(tracking: 0.6pt, body))
#let upper(body) = std-upper(text(tracking: 0.6pt, body))

#let stroke-color = luma(200)
#let fill-color = luma(250)
#let block-float-spacing = 1.75em

#let ilm(
  title: [Your Title],
  author: "Author",
  paper-size: "a4",
  date: none,
  date-format: "[day padding:none] [month repr:long] [year repr:full]",
  abstract: none,
  acknowledgments: none,
  table-of-contents: outline(),
  appendix: (
    enabled: false,
    title: "",
    heading-numbering-format: "",
    body: none,
  ),
  bibliography: none,
  bibliography-title: [References],
  chapter-pagebreak: false,
  figure-index: (
    enabled: true,
    title: "",
  ),
  table-index: (
    enabled: true,
    title: "",
  ),
  listing-index: (
    enabled: true,
    title: "",
  ),
  body-size: none,
  cover-sheet: (
    enabled: false,
    body: none,
  ),
  abbreviations: none,
  symbols: none,
  body,
) = {
  set document(title: title, author: author)

  set text(
    font: ("Times New Roman", "Liberation Serif", "Nimbus Roman"),
    lang: "en",
    region: "GB",
    ..if body-size != none {
      (size: body-size)
    } else {
      (:)
    },
  )

  show raw: set text(font: ("Consolas", "Liberation Mono", "DejaVu Sans Mono"))

  set page(paper: paper-size)

  set par(
    justify: true,
    linebreaks: "optimized",
  )

  show heading: it => {
    it
    v(2%, weak: true)
  }
  show heading: set text(hyphenate: false)

  show link: it => {
    if type(it.dest) == label {
      it
    } else {
      text(fill: rgb("#993333"), it)
    }
  }

  let front-matter-footer = context {
    let physical = here().page()
    let is-odd = calc.odd(physical)
    let aln = if is-odd {
      right
    } else {
      left
    }
    align(aln)[#counter(page).display()]
  }

  let main-matter-footer = context {
    let physical = here().page()
    let is-odd = calc.odd(physical)
    let aln = if is-odd {
      right
    } else {
      left
    }

    let target = heading.where(level: 1)
    let before = query(target.before(here()))
    if before.len() > 0 {
      let current = before.last()
      let gap = 1.75em
      let chapter = upper(text(size: 0.68em, current.body))
      if current.numbering != none {
        if is-odd {
          align(aln)[#chapter #h(gap) #counter(page).display()]
        } else {
          align(aln)[#counter(page).display() #h(gap) #chapter]
        }
      } else {
        align(aln)[#counter(page).display()]
      }
    }
  }

  let has-front-matter = (
    abstract != none
      or acknowledgments != none
      or table-of-contents != none
      or abbreviations != none
      or symbols != none
      or figure-index.enabled
      or table-index.enabled
      or listing-index.enabled
  )

  let fig-t(kind) = figure.where(kind: kind)

  let cover-body = cover-sheet.at("body", default: none)
  if cover-sheet.at("enabled", default: false) and cover-body != none {
    page(numbering: none, margin: 0pt)[#cover-body]
    counter(page).update(1)
  }

  if has-front-matter {
    set page(numbering: "i", footer: front-matter-footer)
    if abstract != none {
      page()[
        #heading(level: 1, outlined: true, numbering: none)[Abstract]
        #abstract
      ]
    }

    if acknowledgments != none {
      page()[
        #heading(level: 1, outlined: true, numbering: none)[Acknowledgments]
        #acknowledgments
      ]
    }

    if table-of-contents != none {
      page()[#table-of-contents]
    }

    if figure-index.enabled or table-index.enabled or listing-index.enabled {
      let imgs = figure-index.enabled
      let tbls = table-index.enabled
      let lsts = listing-index.enabled

      if imgs or tbls or lsts {
        show outline: set heading(outlined: true)
        if imgs {
          page()[
            #outline(
              title: figure-index.at("title", default: "List of Figures"),
              target: fig-t(image),
            )
          ]
        }
        if tbls {
          page()[
            #outline(
              title: table-index.at("title", default: "List of Tables"),
              target: fig-t(table),
            )
          ]
        }
        if lsts {
          page()[
            #outline(
              title: listing-index.at("title", default: "List of Listings"),
              target: fig-t(raw),
            )
          ]
        }
      }
    }

    if abbreviations != none {
      page()[
        #set heading(numbering: none)
        #set par(justify: false, linebreaks: auto)
        #show table.cell: set par(
          justify: false,
          linebreaks: auto,
          leading: 0.65em,
          spacing: 0.65em,
        )
        #abbreviations
      ]
    }

    if symbols != none {
      page()[
        #heading(level: 1, outlined: true, numbering: none)[List of Symbols]
        #set par(justify: false, linebreaks: auto)
        #show table.cell: set par(leading: 0.65em, spacing: 0.65em)
        #symbols
      ]
    }
  }

  set math.equation(numbering: "(1)")

  show raw.where(block: false): box.with(
    fill: fill-color.darken(2%),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

  show raw.where(block: true): block.with(
    inset: (x: 5pt),
    spacing: block-float-spacing,
  )

  show figure: set block(spacing: block-float-spacing)
  show figure.where(kind: table): set block(breakable: true)
  show table: set block(spacing: block-float-spacing)

  set table(
    inset: 7pt,
    stroke: (0.5pt + stroke-color),
  )
  show table.cell: set par(leading: 0.65em, spacing: 0.65em)
  show table.cell.where(y: 0): smallcaps

  {
    set heading(numbering: "1.")

    show heading.where(level: 1): it => {
      if chapter-pagebreak {
        pagebreak(weak: true)
      }
      it
    }
    counter(page).update(1)
    set page(numbering: "1", footer: main-matter-footer)
    body

    if bibliography != none {
      pagebreak()
      show std-bibliography: set std-bibliography(title: bibliography-title)
      show std-bibliography: set text(0.85em)
      show std-bibliography: set par(leading: 0.65em, justify: false, linebreaks: auto)
      bibliography
    }

    if appendix.enabled {
      pagebreak()
      heading(level: 1, numbering: none)[#appendix.at("title", default: "Appendix")]

      let num-fmt = appendix.at("heading-numbering-format", default: "A.1.1.")

      counter(heading).update(0)
      set heading(
        outlined: true,
        numbering: (..nums) => {
          let vals = nums.pos()
          if vals.len() > 0 {
            let v = vals.slice(0)
            return numbering(num-fmt, ..v)
          }
        },
      )

      appendix.body
    }
  }
}

#let blockquote(body) = {
  block(
    width: 100%,
    fill: fill-color,
    inset: 2em,
    stroke: (y: 0.5pt + stroke-color),
    body,
  )
}
