#import "@preview/touying:0.7.4": *
#import themes.simple: *
#import "@preview/herodot:1.0.0": *
#import "@preview/pinit:0.2.2": *

#let rounded-image(path, radius: 12pt, ..args) = box(
  radius: radius,
  clip: true,
  image(path, ..args),
)

#let smaller-speaker-notes(
  self: none,
  width: 0pt,
  height: 0pt,
  cutout: false,
) = {
  let body-fill = rgb("#E6E6E6")
  let body-content = {
    set align(left + top)
    set text(size: 19.5pt)
    pad(
      x: 48pt,
      top: 24pt,
      utils.current-slide-note,
    )
    utils.slide-note-state.update(none)
  }

  let template(fill, content) = block(
    fill: fill,
    width: width,
    height: height,
    content,
  )

  if cutout {
    (
      background: template(body-fill, none),
      foreground: template(none, body-content),
      cutout-height: 0pt,
    )
  } else {
    template(body-fill, body-content)
  }
}

#let larger-section-slide(config: (:), body) = centered-slide(config: config, [
  #text(size: 2.4em, weight: "bold", utils.display-current-heading(level: 1))

  #body
])

#show: simple-theme.with(
  aspect-ratio: "16-9",
  header: none,
  footer: "github universe 2026",
  footer-right: "security by default: a maintainer's wishlist for GitHub Actions v2",
  config-info(
    title: [security by default],
    subtitle: [or: a maintainer's wishlist for GitHub Actions v2],
    author: [william woodruff],
    date: datetime.today(),
  ),
  config-common(
    new-section-slide-fn: larger-section-slide,
    receive-body-for-new-section-slide-fn: true,
    show-notes-on-second-screen: right,
  ),
  config-methods(
    show-only-notes: smaller-speaker-notes,
  ),
)

#set text(font: "Inter")

#title-slide[
  #touying-fn-wrapper((self: none) => stack(
    dir: ttb,
    spacing: .9em,
    text(size: 2em, weight: "bold", self.info.title),
    self.info.subtitle,
    1em,
    text(size: .85em, fill: self.colors.neutral-light, emph(self.info.author)),
  ))
]

#speaker-note[

]

== intro

#align(horizon)[
  #move(dy: -0.5em)[
    #grid(
      columns: (1.66fr, 2fr),
      gutter: 2em,
      align: center + horizon,
      [
        #rounded-image("assets/me.jpg", width: 100%)
      ],
      [
        #grid(
          columns: (1fr, 1fr),
          column-gutter: 1.5em,
          row-gutter: 0.65em,
          align: center + horizon,
          grid.cell(colspan: 2)[
            #image("assets/zizmor.png", width: 65%)
          ],
          [
            #image("assets/oai.png", height: 3.6em)
          ],
          [
            #rounded-image("assets/astral.png", width: 3.4em, height: 3.4em)
          ],

          [
            #image("assets/brew.svg", height: 3.8em)
          ],
          [
            #image("assets/pypi.svg", height: 3.2em)
          ],
        )
      ],
    )
  ]
]

#speaker-note[
  - That's me on the left.
  - Just a little bit about me. I'm a Member of Technical Staff at OpenAI, where I work on the Astral team. Specifically, I mostly work on uv, which some of you probably use.
  - Outside of work, I've been involved in open source for a while.
  - Among other things, I'm one of Homebrew's maintainers, as well as one of the maintainers of PyPI.
  - However, this talk and its contents reflect my own thoughts and opinions. It doesn't necessarily reflect the opinions of my employer or any of the projects I help maintain.
]

== #emoji.rainbow zizmor

// Shift the image and commands up together, leaving more room above the footer.
#v(-0.75em)

#block(width: 100%, height: 1fr, below: 0.2em)[
  #image("assets/zizmor-cli-1.png", width: 100%, height: 100%, fit: "contain")
]

#v(0.75em)

#speaker-note[
  - Actually, I kind of buried the lede a bit.
  - I'm also the creator and maintainer of zizmor.
  - If you don't know zizmor, it's a static analysis tool for CI/CD, including GitHub Actions.
  - It finds many of the most well known (and some not-so-well-known) security footguns in GitHub Actions, and can report them using diagnostics like the kind shown here.
  - It also supports SARIF, so you can integrate it directly into GitHub's Advanced Security or any other tool that can consume SARIF.
  - Thanks to my open source work and zizmor in particular, I have a lot of opinions about GitHub Actions. By the end of this talk, I hope you'll have a lot more opinions as well.
]

== GitHub Actions circa 54 BCE

#block(width: 100%, height: 1fr)[
  #grid(
    columns: (1fr, 1fr),
    rows: (1fr,),
    column-gutter: 1em,
    align: (center + horizon, left + horizon),
    [
      #rounded-image("assets/catullus.jpg", height: 100%)
    ],
    [
      #set par(leading: 0.55em)
      #show quote.where(block: true): it => block(
        width: 100%,
        inset: (left: 0.8em),
        stroke: (left: 2pt + rgb("#D8D8D8")),
        it.body,
      )
      #quote(block: true)[
        #text(font: "Libertinus Serif", size: 23pt, style: "italic")[
          Ōdī et amō. \
          Quārē id faciam fortasse requīris. \
          Nesciŏ, sed fierī sentiō et excrucior.
        ]

        #v(0.6em)

        #text(size: 19pt, fill: rgb("#555555"))[
          I love and I hate. Why, you might ask? \
          I do not know, \
          but I feel and am tortured.
        ]

        #v(0.5em)

        #text(size: 15pt, fill: rgb("#777777"))[Catullus _85_]
      ]
    ],
  )
]

#speaker-note[
  - This is Gaius Valerius Catullus. He was a neoteric poet in the late Roman Republic.
  - Catullus is mostly notable if you study Latin, or if you like lascivious poetry, or both.
  - Catullus lived and died without ever having to debug or secure a GitHub Actions workflow.
  - Despite that, Catullus understood on a deep level what it was like to use GitHub Actions.
  - We know this because of the 85th poem in his canon, shown here.
]

= #emoji.heart amō

#text(size: 1.1em, fill: rgb("#777777"))[
  _"i love"_
]

#speaker-note[
  - We can start with the positive things, the things I love about GitHub Actions.
]

== #emoji.heart amō

#block(width: 100%, height: 1fr)[
  #grid(
    columns: (1fr, 1.15fr),
    rows: (1fr,),
    column-gutter: 1em,
    align: center + horizon,
    [
      #rounded-image("assets/predator.jpg", width: 100%)
    ],
    [
      #stack(
        dir: ttb,
        spacing: 0.65em,
        rounded-image("assets/typical-matrix.png", width: 100%),
        rounded-image("assets/lots-of-yaml.png", width: 100%),
      )
    ],
  )
]

#speaker-note[
  - First: GitHub Actions is an _amazing_ resource. It's functionallity free and unlimited compute for the world's open source. If I had to pay for what GitHub Actions gives me for free, it eaily would cost me a few thousand dollars a year.
  - Stategically, GitHub Actions is also a great example of aligned interests: GitHub, Microsoft, etc. benefit from reliable, well-tested open source software, and OSS maintainers don't otherwise have the time and resources to maintain build environments for every platform they might want to target. Both parties win.
  - Finally, GitHub Actions (and CI/CD more generally) is a great example practical "shifting left": isolated CI/CD runners mean that OSS maintainers can do fewer sensitive things on local machines, and more things on ephemeral, isolated runners where access can be carefully introduced, intermediated, and audited.
]

== #emoji.heart amō

#speaker-note[
  - Real-world examples of these positive qualities abound.
  - For one, it's incredibly easy to build and test OSS on GitHub Actions, especially for platforms other than the one I use on a daily basis. Tens of thousands of major projects on GitHub ship the full matrix of `{x86, x64, arm64} x {Windows, macOS, Linux}` in their releases because of how straightforward GitHub Actions makes it.
  - Even this is an under-approximation for ecosystems like Python, where it's common ship many build variants for different libc versions, etc.
  - For another, GitHub adopted OIDC early, relative to other CI/CD providers. This spurred the development of techniques like Trusted Publishing for "credential-less" authentication.
  - Trusted Publishing started with PyPI and has now seen widespread adoption in the Ruby, Rust, and JavaScript communities, in no small part thanks to the foundation supplied by GitHub Actions.
]

== power

#block(width: 100%, height: 1fr)[
  #grid(
    columns: (1fr, 1fr),
    rows: (1fr,),
    column-gutter: 1em,
    align: center + horizon,
    [
      #rounded-image("assets/matrix.png", width: 100%)
    ],
    [
      #rounded-image("assets/permissions.png", width: 100%)
      #rounded-image("assets/root.png", width: 100%)
    ],
  )
]

#speaker-note[
  - So much of what makes GitHub Actions amazing is how _powerful_ it is.
  - With a little bit of YAML scaffolding, it gives us root access to virtual machines, with root, that have direct access to the public Internet.
  - Despite being so general as an execution layer, GitHub Actions also exposes a very _specialized_ and rich view into GitHub's own data model: triggers for things like pushes and PRs, API access via a built-in `GITHUB_TOKEN`, deployments and environments, etc.
  - Finally, GitHub Actions is powerful because it's also an _ecosystem_. If you're like me, you depend on dozens of actions and reusable workflows that are maintained by both GitHub themselves and open source maintainers.
  - This ecosystem effect goes a long way towards reducing the drudgery problem in CI/CD, where every little thing needs to be built from the ground up.
]

= #emoji.face.angry ōdī

#text(size: 1.1em, fill: rgb("#777777"))[
  _"i hate"_
]

#speaker-note[
  - GitHub Actions is powerful, but power is also its own kind of weakness.
  - In the case of Actions, that weakness manifests in three main domains that I want to talk about today.
  - The first two are firmly in the category of security, and are things that I think GitHub can begin to improve, starting today.
  - The last one is thornier, because it's a social weakness, and requires both GitHub and the larger OSS community to engage in some soul searching about the future of our shared open source endeavor.
  - However, I include it because I think it's also a security concern.
  - For each of these, I'll break it down "wishlist" style: I'll talk about the _why_ of the problems that occur, and _how_ I think GitHub could address each problem.
]

== #emoji.face.angry ōdī

#v(0.5em)

#block(width: 95%)[
  #set text(size: 30pt)
  #set list(spacing: 0.9em)
  #show list: it => {
    show list: set text(size: 20pt, fill: rgb("#555555"))
    show list: set block(above: 0.3em, below: 0pt)
    it
  }

  - insecure platform defaults
    - or: "i need a tool to solve what the platform should solve for me"
  - insecure community practices
    - or: "my entire CI/CD depends on mystery meat from `curl | bash`"
  - reliability and availability
    - or "if i see one more outage i'm going back to jenkins"
]

#speaker-note[
  - These are my three domains.
  - First, we're going to talk about the problem of insecure defaults on GitHub Action, and why so many people end up reaching for tools (like `zizmor`) that can only paper over the problem rather than fixing it systematically.
  - Then, we'll talk about insecure community practices on GitHub Actions. These will be things that GitHub can't necessarily fix as a platform, but can potentially nudge people away from over time.
  - Finally, we'll talk about the elephant in the room: the perception that Actions is no longer reliable as a service.
  - A lot of ink has been spilled over this topic already, but I'm going to frame it in terms of security.
]

== #emoji.face.angry ōdī: insecure platform defaults

#slide(
  config: utils.merge-dicts(
    config-page(
      header: none,
      footer: none,
      margin: (x: 1.25em, y: 1em),
    ),
    config-common(subslide-preamble: none),
  ),
)[
  #let qr-link(path, caption) = grid(
    columns: (8.2em, 1fr),
    column-gutter: 0.3em,
    align: left + horizon,
    image(path, width: 100%), text(size: 0.85em)[#caption],
  )

  #block(width: 100%, height: 1fr)[
    #grid(
      columns: (6em, 1fr),
      rows: (1fr,),
      column-gutter: 0.75em,
      align: left + horizon,
      [
        #set par(leading: 0.15em)
        #text(size: 2em, weight: "bold")[thank \ you]
      ],
      [
        #grid(
          columns: (1fr, 1fr),
          rows: (1fr, 1fr),
          gutter: 0.4em,
          align: left + horizon,
          qr-link("assets/slides-qr.png", [slides]), qr-link("assets/personal-website-qr.png", [personal website]),
          qr-link("assets/blog-qr.png", [blog]), qr-link("assets/zizmor-qr.png", [zizmor]),
        )
      ],
    )
  ]
]
