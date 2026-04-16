#let ieee(
  title: [Paper Title],
  authors: (),
  abstract: none,
  index-terms: (),
  index-label: "Index Terms",
  bibliography: none,
  figure-supplement: [Figure],
  body,
) = {
  set document(title: title, author: authors.map(author => author.name))

  set text(font: "Times New Roman", size: 11pt, spacing: .35em)

  set enum(numbering: "1)a)i)")

  show figure: set block(spacing: 15.5pt)
  show figure: set place(clearance: 15.5pt)
  show figure.where(kind: table): set figure.caption(position: top, separator: [\ ])
  show figure.where(kind: table): set text(size: 10pt)
  show figure.where(kind: table): set figure(numbering: "I")
  show figure.where(kind: image): set figure(supplement: figure-supplement, numbering: "1")
  show figure.caption: set text(size: 10pt)

  show figure.caption: set align(center)

  set figure.caption(separator: [. ])
  show figure: fig => {
    let prefix = (
      if fig.kind == table [TABLE] else if fig.kind == image [#figure-supplement] else [#fig.supplement]
    )
    let numbers = numbering(fig.numbering, ..fig.counter.at(fig.location()))
    {
      show figure.caption: it => block[
        #text(size: 10pt)[#upper[#prefix~#numbers]]#linebreak()#text(size: 10pt)[#smallcaps(it.body)]
      ]
      fig
      par(spacing: 0pt, first-line-indent: 0pt)[#sym.zws]
    }
  }

  show raw: set text(
    font: "TeX Gyre Cursor",
    ligatures: false,
    size: 1em / 0.8,
    spacing: 100%,
  )

  set columns(gutter: 14.4pt)
  set page(
    columns: 2,
    paper: "a4",
    margin: (
      x: 54pt,
      top: 54pt,
      bottom: 72pt,
    ),
  )

  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)

  show ref: it => {
    if it.element != none and it.element.func() == math.equation {
      link(it.element.location(), numbering(
        it.element.numbering,
        ..counter(math.equation).at(it.element.location()),
      ))
    } else {
      it
    }
  }

  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt)

  set heading(numbering: "I.A.1)")

  show heading: it => {
    let levels = counter(heading).get()
    let deepest = if levels != () { levels.last() } else { 1 }

    set text(11pt, weight: 400)

    if it.level == 1 {
      let is-ack = (
        it.body
          in (
            [Acknowledgment],
            [Acknowledgement],
            [Acknowledgments],
            [Acknowledgements],
          )
      )
      set align(center)
      set text(11pt)
      set text(weight: 700)
      show: block.with(above: 8pt, below: 8pt, sticky: true)
      show: smallcaps
      if it.numbering != none and not is-ack {
        numbering("I.", deepest)
        h(7pt, weak: true)
      }
      it.body
    } else if it.level == 2 {
      set text(style: "italic")
      set text(size: 11pt)
      show: block.with(
        spacing: 6pt,
        sticky: true,
      )
      if it.numbering != none {
        numbering("A.", deepest)
        h(7pt, weak: true)
      }
      it.body
    } else [
      #if it.level == 3 {
        numbering("1)", deepest)
        [ ]
      }
      _#(it.body):_
    ]
  }

  show std.bibliography: set text(10pt)
  show std.bibliography: set block(spacing: 0.5em)
  set std.bibliography(title: text(11pt)[References], style: "ieee")

  place(
    top + center,
    float: true,
    scope: "parent",
    clearance: 30pt,
    {
      show std.title: set align(center)
      show std.title: set par(leading: 0.5em)
      show std.title: set text(size: 24pt, weight: "regular")
      show std.title: set block(below: 8.35mm)
      std.title()

      set par(leading: 0.6em)
      for i in range(calc.ceil(authors.len() / 3)) {
        let end = calc.min((i + 1) * 3, authors.len())
        let is-last = authors.len() == end
        let slice = authors.slice(i * 3, end)
        grid(
          columns: slice.len() * (1fr,),
          gutter: 12pt,
          ..slice.map(author => align(center, {
            text(size: 11pt, author.name)
            if "department" in author [
              \ #author.department
            ]
            if "organization" in author or "email" in author {
              let has-org = "organization" in author
              let has-mail = "email" in author
              [\ #if has-org and has-mail {
                author.organization
                [, ]
                author.email
              } else if has-org {
                author.organization
              } else {
                author.email
              }]
            }
            if "location" in author [
              \ #author.location
            ]
          }))
        )

        if not is-last {
          v(16pt, weak: true)
        }
      }
    },
  )

  set par(
    justify: true,
    first-line-indent: (amount: 18pt),
    spacing: 0.5em,
    leading: 0.5em,
  )

  if abstract != none {
    set par(spacing: 0.45em, leading: 0.45em)
    set text(
      size: 11pt,
      weight: 700,
      spacing: 150%,
    )

    [_Abstract_ - #abstract]

    if index-terms != () {
      parbreak()
      text(weight: 400)[#emph(index-label) - #index-terms.join[, ]]
    }
    v(2pt)
  }

  body

  bibliography
}