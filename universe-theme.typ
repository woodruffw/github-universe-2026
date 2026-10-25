#import "@preview/touying:0.7.4": *
#import themes.simple: simple-theme, slide, centered-slide

// Dimensions, colors, fonts, and artwork come from the light master in
// template.potx. PowerPoint's EMU coordinates are converted to points (÷ 12700).
#let universe = (
  width: 959.75pt,
  height: 540pt,
  green: rgb("#08872A"),
  // PowerPoint's lumMod operates on HSL lightness. Preserve the resulting
  // fractional sRGB channels instead of rounding them to hex bytes.
  muted: rgb(31.610644%, 36.792717%, 40.938375%),
  footer-text: rgb(48.550420%, 55.063025%, 60.273109%),
  line: rgb("#B0BAC2"),
  panel: rgb("#F3F6F2"),
)

#let universe-footer-with(fill: universe.footer-text) = {
  place(top + left, dx: -0.004961pt, dy: 506.862205pt, rect(
    width: 959.76pt, height: 1.44pt, fill: universe.green, stroke: none,
  ))
  place(top + left, dx: 899.34126pt, dy: 508.32pt, rect(
    width: 0.72pt, height: 31.68pt, fill: universe.line, stroke: none,
  ))
  place(top + left, dx: 4.627008pt, dy: 514.251417pt,
    image("assets/universe-template/github-mark.svg", width: 20.495984pt, height: 19.817244pt, fit: "stretch"))
  place(top + left, dx: 907.977008pt, dy: 514.08pt,
    image("assets/universe-template/universe-26.svg", width: 43.795984pt, height: 20.16pt, fit: "stretch"))
  place(top + left, dx: 33.03874pt, dy: 519.31315pt, block(width: 858.382441pt, height: 9.69378pt)[
    #set text(font: "Mona Sans Mono", size: 8pt, fill: fill)
    #align(right + horizon)[
      #upper("security by default: a maintainer's wishlist for GitHub Actions v2")
    ]
  ])
}

#let universe-footer = universe-footer-with()

#let universe-heading(body, size: 48pt, width: 100%, height: 121.029291pt, font: "Mona Sans Display", offset: 0pt) = block(
  width: width, height: height, above: 0pt, below: 0pt,
)[
  #place(top + left, dx: offset, block(width: 100%)[
    #set text(font: font, size: size, weight: "regular", top-edge: "ascender")
    #utils.fit-to-width(grow: false, 100%, body)
  ])
]

#let section-slide(config: (:), body) = centered-slide(
  config: utils.merge-dicts(
    config-page(margin: (left: 31.280315pt, right: 29.874961pt, top: 33pt, bottom: 33.155591pt)),
    config,
  ),
)[
  #align(left + bottom)[
    #set text(font: "Mona Sans", size: 96pt, weight: "regular", bottom-edge: "descender")
    // The master uses 90% line spacing. Mona's 1.41em line box becomes
    // 1.269em between baselines: cap-height .729 + descender .32 + .22.
    #set par(leading: 0.22em)
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
      (471.835276pt, "Mona Sans", black, self.info.author),
      (493.549213pt, "Mona Sans Display", universe.footer-text, role),
      (515.196378pt, "Mona Sans Display", universe.footer-text, company),
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
  #place(top + left, dx: 31.280315pt, dy: 31.697795pt, box(
    radius: 11.444pt, clip: true,
    image(photo, width: 401.544488pt, height: 443.537087pt, fit: "cover"),
  ))
  #place(top + left, dx: 464.105118pt, dy: 31.697795pt,
    block(width: 464.324882pt, height: 443.537087pt)[
      #grid(
        columns: (1fr,),
        rows: (auto, 8pt, 18.747638pt, 32.339685pt, 1fr),
        [
          // Fit the name's actual height instead of reserving the template's
          // second line. Keep the role and bio together as the name reflows.
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

// Measure unwrapped code before fitting it, preserving its indentation.
#let fit-code(body, centered: false) = layout(size => {
  let natural = measure(body)
  let ratio = calc.min(1, size.width / natural.width, size.height / natural.height)
  let fitted = scale(x: ratio * 100%, y: ratio * 100%, reflow: true,
    block(width: natural.width, above: 0pt, below: 0pt, body))
  if centered {
    block(width: 100%, height: 100%, above: 0pt, below: 0pt)[
      #align(left + horizon)[#fitted]
    ]
  } else {
    fitted
  }
})

#let code-slide(captioned: false, config: (:), body) = slide(
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
      utils.display-current-heading(level: 2), size: 36pt,
      // Uncaptioned code gets equal 33pt insets inside the pale panel.
      height: if captioned { 102.520315pt } else { 102.4pt }, font: "Mona Sans",
    )),
    config,
  ),
  block(width: 100%, height: 1fr, above: 0pt, below: 0pt)[
    #show raw.where(block: true): set par(leading: 0.22em + 10pt)
    #if not captioned {
      // Balance the font's top and bottom extents with uniform line spacing.
      show raw.where(block: true): set text(top-edge: "cap-height", bottom-edge: "descender")
      show raw.where(block: true): it => fit-code(it, centered: true)
      body
    } else {
      body
    }
  ],
)

// Light Title and Content (83), for slides whose body is text rather than images.
#let text-slide(body) = slide(
  config: utils.merge-dicts(
    config-page(margin: (
      left: 31.679921pt, right: 32.040079pt,
      top: 62.707638pt, bottom: 64.529055pt,
    )),
    config-common(subslide-preamble: universe-heading(
      utils.display-current-heading(level: 2), width: 896.749921pt, height: 72.008897pt,
    )),
  ),
  body,
)

// Light Blank (117): equal insets above the content and above the footer.
#let untitled-slide(body) = slide(
  config: utils.merge-dicts(
    config-page(
      margin: (x: 31.68pt, top: 31.68pt, bottom: 64.765pt),
      background: universe-footer-with(fill: universe.muted),
    ),
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
        // The rule is a rotated rectangle in the source layout. Rotate about
        // its center rather than attaching it to the panel's left edge.
        place(top + left, dx: 409.876535pt,
          rect(width: 1.44pt, height: 540pt, fill: universe.green, stroke: none))
      },
    ),
    config-common(subslide-preamble: none),
  ),
)[
  #place(top + left, dy: 0.840079pt, block(width: 349.361575pt)[
    #universe-heading(utils.display-current-heading(level: 2), size: 36pt, height: 79.946535pt, font: "Mona Sans")
  ])
  #place(top + left, dy: 87.366457pt, block(width: 349.361575pt, height: 385.793465pt)[
    #align(center + horizon)[#left-body]
  ])
  #place(top + left, dx: 412.018111pt, dy: 24.962756pt,
    block(width: 487.98189pt, height: 448.197165pt)[
      #show raw.where(block: true): set par(leading: 0.22em + 10pt)
      #code-body
    ])
]

#let universe-theme(..args, body) = {
  show: simple-theme.with(
    header: none, header-right: none, footer: none, footer-right: none,
    subslide-preamble: universe-heading(utils.display-current-heading(level: 2), offset: -0.139371pt),
    config-page(
      width: universe.width, height: universe.height, fill: white,
      margin: (
        left: 31.899843pt, right: 31.32pt,
        top: 62.693307pt, bottom: 64.765197pt,
      ),
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
      set text(font: "Mona Sans", size: 21.99pt, weight: "regular", fill: black)
      set par(leading: 0.22em)
      set raw(theme: "universe-code.tmTheme", syntaxes: (
        "zizmor.sublime-syntax", "git-output.sublime-syntax",
      ))
      // Keep operators literal: the release's code ligatures collapse == to =.
      show raw: set text(font: "Mona Sans Mono", ligatures: false, features: (calt: 0))
      show raw.where(lang: "zizmor").or(raw.where(lang: "git-output")): it => {
        // Keep bold output in its token color instead of Touying's alert green.
        show strong: body => text(weight: "bold", body.body)
        it
      }
      show raw.where(block: true): set text(size: 23.99pt, top-edge: "ascender")
      show raw.where(block: true): set par(leading: 0pt)
      show raw.where(block: true): fit-code
      body
    }),
    ..args,
  )
  body
}
