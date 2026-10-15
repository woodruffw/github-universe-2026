#import "@preview/touying:0.7.4": *
#import themes.simple: simple-theme, slide, centered-slide

// Dimensions, colors, fonts, and artwork come from the light master in
// template.potx. PowerPoint's EMU coordinates are converted to points (÷ 12700).
#let universe = (
  width: 959.75pt,
  height: 540pt,
  green: rgb("#08872A"),
  muted: rgb("#515E68"),
  footer-text: rgb("#7C8C9A"),
  line: rgb("#B0BAC2"),
  panel: rgb("#F3F6F2"),
)

#let universe-footer = {
  place(top + left, dy: 506.862pt, rect(
    width: universe.width, height: 1.44pt, fill: universe.green, stroke: none,
  ))
  place(top + left, dx: 899.341pt, dy: 508.32pt, rect(
    width: 0.72pt, height: 31.68pt, fill: universe.line, stroke: none,
  ))
  place(top + left, dx: 4.627pt, dy: 514.251pt,
    image("assets/universe-template/github-mark.svg", width: 20.496pt, height: 19.817pt))
  place(top + left, dx: 907.977pt, dy: 514.08pt,
    image("assets/universe-template/universe-26.svg", width: 43.796pt, height: 20.16pt))
  place(top + left, dx: 33.039pt, dy: 519.313pt, block(width: 858.382pt, height: 9.694pt)[
    #set text(font: "Mona Sans Mono", size: 8pt, fill: universe.footer-text)
    #align(right + horizon)[
      #upper("security by default: a maintainer's wishlist for GitHub Actions v2")
    ]
  ])
}

#let universe-heading(body, size: 48pt, height: 121.015pt, font: "Mona Sans Display") = block(
  width: 100%, height: height, above: 0pt, below: 0pt,
)[
  #set text(font: font, size: size, weight: "regular", top-edge: "ascender")
  #utils.fit-to-width(grow: false, 100%, body)
]

#let section-slide(config: (:), body) = centered-slide(
  config: utils.merge-dicts(
    // Keep descenders and section subtitles clear of the footer rule.
    config-page(margin: (left: 31.28pt, right: 29.875pt, top: 33pt, bottom: 49.156pt)),
    config,
  ),
)[
  #align(left + bottom)[
    #set text(font: "Mona Sans", size: 96pt, weight: "regular", bottom-edge: "descender")
    #set par(leading: 0.14em)
    #block(above: 0pt, below: 0pt)[#utils.display-current-heading(level: 1)]
    #v(12pt, weak: true)
    #text(font: "Mona Sans", size: 22pt)[#body]
  ]
]

// Light Speaker Card (1), layout 65, including its bottom-left portrait slot.
#let title-slide(photo: none, role: [], company: [], config: (:), body) = slide(
  config: utils.merge-dicts(
    config-page(
      margin: 0pt,
      background: {
        // The source PNG has a transparent bottom edge beneath the mascot.
        place(top + left, dy: 538pt,
          rect(width: 124pt, height: 2pt, fill: rgb("#1A0C29"), stroke: none))
        place(top + left, image("assets/universe-template/title-rail.png", width: 124pt, height: 540pt))
        place(top + left, dx: 124pt, dy: 458.936pt,
          rect(width: 835.75pt, height: 2.88pt, fill: universe.green, stroke: none))
      },
    ),
    config-common(freeze-slide-counter: true, subslide-preamble: none),
    config,
  ),
)[
  #if photo != none {
    place(top + left, dx: 124.878pt, dy: 461.816pt,
      image(photo, width: 77.174pt, height: 78.311pt, fit: "cover"))
  }
  #touying-fn-wrapper((self: none) => {
    // Use the same text alignment for all three fields so their baselines
    // remain evenly spaced despite the template's mixed text-box anchors.
    for (y, font, fill, content) in (
      (471.835pt, "Mona Sans", black, self.info.author),
      (493.515pt, "Mona Sans Display", universe.footer-text, role),
      (515.195pt, "Mona Sans Display", universe.footer-text, company),
    ) {
      place(top + left, dx: 214.937pt, dy: y,
        block(width: 729.938pt)[
          #set text(font: font, size: 14pt, weight: "regular", fill: fill,
            top-edge: "cap-height", bottom-edge: "descender")
          #content
        ])
    }
  })
  #body
]

// Light Speaker bio, layout 78. The speaker name comes from config-info;
// the role and bio content are supplied by the slide.
#let speaker-slide(photo, role: [], body) = slide(
  config: utils.merge-dicts(
    config-page(margin: 0pt),
    config-common(subslide-preamble: none),
  ),
)[
  #place(top + left, dx: 31.280pt, dy: 31.698pt, box(
    radius: 11.444pt, clip: true,
    image(photo, width: 401.544pt, height: 443.537pt, fit: "cover"),
  ))
  #place(top + left, dx: 464.105pt, dy: 31.698pt,
    block(width: 464.325pt, height: 443.537pt)[
      #grid(
        columns: (1fr,),
        rows: (auto, 8pt, 18.748pt, 32.34pt, 1fr),
        [
          // Collapse the template's unused second name line and keep a
          // consistent visible gap before the role.
          #set text(font: "Mona Sans Display", size: 35.99pt, weight: "regular", top-edge: "ascender")
          #touying-fn-wrapper((self: none) => self.info.author)
        ],
        [],
        [
          #set text(font: "Mona Sans Mono", size: 13.99pt, weight: "regular", fill: universe.footer-text, top-edge: "ascender")
          #upper(role)
        ],
        [],
        [
          #set text(font: "Mona Sans", size: 20pt, weight: "regular")
          #align(left + top)[#body]
        ],
      )
    ])
]

#let code-slide(config: (:), body) = slide(
  config: utils.merge-dicts(
    config-page(
      margin: (x: 29.875pt, top: 33pt, bottom: 33pt),
      background: {
        place(top + left, dy: 102.4pt,
          rect(width: universe.width, height: 437.6pt, fill: universe.panel, stroke: none))
        place(top + left, dy: 100.316pt,
          rect(width: universe.width, height: 1.44pt, fill: universe.green, stroke: none))
      },
    ),
    config-common(subslide-preamble: universe-heading(
      utils.display-current-heading(level: 2), size: 36pt, height: 126.643pt, font: "Mona Sans",
    )),
    config,
  ),
  block(width: 100%, height: 1fr, above: 0pt, below: 0pt, body),
)

// Light Title and Content (83), for slides whose body is text rather than images.
#let text-slide(body) = slide(
  config: config-common(subslide-preamble: universe-heading(
    utils.display-current-heading(level: 2), height: 72.009pt,
  )),
  body,
)

// Light Blank (117): equal insets above the content and above the footer.
#let untitled-slide(body) = slide(
  config: utils.merge-dicts(
    config-page(margin: (x: 31.68pt, top: 31.68pt, bottom: 64.765pt)),
    config-common(subslide-preamble: none),
  ),
  body,
)

// Light Developer Code Right (110). Keep both columns on the master grid.
#let code-right-slide(left-body, code-body) = slide(
  config: utils.merge-dicts(
    config-page(
      margin: (x: 29.875pt, top: 33pt, bottom: 33.803pt),
      background: {
        place(top + left, dx: 409.813pt,
          rect(width: 549.937pt, height: 540pt, fill: universe.panel, stroke: none))
        place(top + left, dx: 408.373pt,
          rect(width: 1.44pt, height: 540pt, fill: universe.green, stroke: none))
      },
    ),
    config-common(subslide-preamble: none),
  ),
)[
  #place(top + left, block(width: 349.36pt)[
    #universe-heading(utils.display-current-heading(level: 2), size: 36pt, height: 79.95pt, font: "Mona Sans")
  ])
  #place(top + left, dy: 87.37pt, block(width: 349.36pt, height: 385.797pt)[
    #align(center + horizon)[#left-body]
  ])
  #place(top + left, dx: 412.018pt, dy: 24.963pt,
    block(width: 487.982pt, height: 448.234pt)[#code-body])
]

#let universe-theme(..args, body) = {
  show: simple-theme.with(
    header: none, header-right: none, footer: none, footer-right: none,
    subslide-preamble: universe-heading(utils.display-current-heading(level: 2)),
    config-page(
      width: universe.width, height: universe.height, fill: white,
      margin: (x: 31.68pt, top: 62.708pt, bottom: 64.765pt),
      background: universe-footer,
    ),
    config-colors(
      primary: universe.green,
      neutral-light: universe.muted,
      neutral-lightest: white,
      neutral-darkest: black,
    ),
    config-common(new-section-slide-fn: section-slide),
    config-methods(init: (self: none, body) => {
      set text(font: "Mona Sans", size: 22pt, weight: "regular", fill: black)
      set par(leading: 0.45em)
      set raw(theme: "universe-code.tmTheme")
      show raw: set text(font: "Mona Sans Mono")
      show raw.where(block: true): set text(size: 23.99pt, top-edge: "ascender")
      show raw.where(block: true): set par(leading: 0pt)
      // Measure unwrapped code, then fit it within its available column/slide.
      // This preserves the source text, indentation, and diagnostic underlines.
      show raw.where(block: true): it => layout(size => {
        let natural = measure(it)
        let ratio = calc.min(1, size.width / natural.width, size.height / natural.height)
        scale(x: ratio * 100%, y: ratio * 100%, reflow: true,
          block(width: natural.width, above: 0pt, below: 0pt, it))
      })
      body
    }),
    ..args,
  )
  body
}
