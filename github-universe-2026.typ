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
  - Outside of work, I've been involved in open source for over a decade.
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
      #box(height: 100%, fill: rgb("#334155"), radius: 17pt, inset: 5pt)[
        #rounded-image("assets/catullus.jpg", height: 100%)
      ]
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

#block(width: 100%, height: 1fr)[
  #grid(
    columns: (1fr, 1fr),
    rows: (1fr,),
    column-gutter: 1em,
    align: (center + horizon, left + horizon),
    [
      #box(height: 100%, fill: rgb("#334155"), radius: 17pt, inset: 5pt)[
        #rounded-image("assets/tp-enroll.png", height: 100%)
      ]
    ],
    [
      #block(width: 100%, fill: rgb("#F5F5F5"), radius: 12pt, inset: 0.65em)[
        #show raw: set text(size: 20pt)
        ```yaml
        jobs:
          # look ma, no secrets
          publish:
            permissions:
              id-token: write
            steps:
              - run: "# ..."
              - run: "uv build"
              - run: "uv publish"
        ```
      ]
    ],
  )
]

#speaker-note[
  - Real-world examples of these positive qualities abound.
  - For one, it's incredibly easy to build and test OSS on GitHub Actions, especially for platforms other than the one I use on a daily basis. Tens of thousands of major projects on GitHub ship the full matrix of `{x86, x64, arm64} x {Windows, macOS, Linux}` in their releases because of how straightforward GitHub Actions makes it.
  - Even this is an under-approximation for ecosystems like Python, where it's common ship many build variants for different libc versions, etc.
  - For another, GitHub adopted OIDC early, relative to other CI/CD providers. This spurred the development of techniques like Trusted Publishing for "credential-less" authentication.
  - Trusted Publishing started with PyPI and has now seen widespread adoption in the Ruby, Rust, and JavaScript communities, in no small part thanks to the foundation supplied by GitHub Actions.
]

== #emoji.heart amō

#block(width: 100%, height: 1fr)[
  #align(center)[
    #box(height: 100%, fill: rgb("#334155"), radius: 17pt, inset: 5pt)[
      #rounded-image("assets/cryptography-wheels.png", height: 100%)
    ]
  ]
]

#speaker-note[
  - I like this screenshot because it shows just how material these positive qualities are.
  - This is just a small handful of the wheels, which are binaries, that the `cryptography` package on PyPI publishes from GitHub with every single release. There are 58 of them total on each release currently, so the full list wouldn't fit on this slide.
  - Every single one of them gets built and tested on GitHub Actions, and published through Trusted Publishing.
  - Those builds then end up powering cryptography in most of the world's Python codebases. And GitHub Actions is a key enabler of that!
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

  - insecure platform defaults and footguns
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

= platform defaults and footguns

#speaker-note[
  - Let's talk about insecure defaults and footguns. GitHub Actions has developed a reputation for having both of these.
  - In the interest of being fair, it's worth noting that GitHub _has_ fixed many of the insecure defaults in Actions in recent months.
  - Still, there are plenty more to go around. Let's look at a few of them.
]

== (insecure) platform defaults and footguns

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v5
      - run: cargo build
      - uses: actions/upload-artifact@v4
        with:
          name: build
          path: .
```

#speaker-note[
  - Let's start on the smaller end of things.
  - This is a pretty normal looking GitHub Actions workflow. If you're like me, you probably see some take on this several times a week.
  - But it also contains a pretty bad security vulnerability!
]

== (insecure) platform defaults

#align(center + horizon)[
  #show raw: set text(size: 15pt)
  #set par(leading: 0.3em)

  ```
  $ zizmor example-workflows/artipacked.yml
  error[artipacked]: credential persistence through GitHub Actions artifacts
    --> example-workflows/artipacked.yml:9:9
     |
   9 |         - uses: actions/checkout@v5
     |           ^^^^^^^^^^^^^^^^^^^^^^^^^ does not set persist-credentials: false
  10 |         - run: cargo build
  11 |         - uses: actions/upload-artifact@v4.3.5
     |  _________-
  12 | |         with:
  13 | |           name: build
  14 | |           path: .
     | |__________________- may leak the credentials persisted above
     |
     = note: audit confidence → High
     = note: this finding has an auto-fix
  ```
]

#speaker-note[
  - If you ran that workflow through zizmor, you'd see something like this.
  - The vulnerability here involves not one, not two, but three insecure defaults at once.
  - First, older repositories default to a read-write token for GitHub Actions by default. That means that, even if you don't set an explicit write permission, most jobs get a token that can can modify PRs, push contents, etc.
  - Second, the `checkout` action persists its credentials by default. In this specific version, v5, it does that by writing the `GITHUB_TOKEN` directly to a `.git/config` file in the working directory.
  - Third and finally, the `upload-artifact` action uploads _everything_ in the directory it's given, including hidden files and directories like `.git`.
  - When combined, these mean that an innocent maintainer is now uploading a write-capable `GITHUB_TOKEN` to a publicly readable actions artifact. Anybody can find that artifact and exfiltrate the token from it.
  - Palo Alto Networks described this vulnerability class in 2024, and termed it "artipacked."
]

== (insecure) platform defaults

#slide(config: config-common(subslide-preamble: none))[
  #align(center + horizon)[
    #grid(
      columns: (1fr, 1.6fr),
      gutter: 0.75em,
      align: center + horizon,
      [
        #rounded-image("assets/github-blog-1.png", width: 100%)
      ],
      [
        #rounded-image("assets/upload-artifact.png", width: 100%)
      ],
      grid.cell(colspan: 2)[
        #rounded-image("assets/checkout-security.png", width: 100%)
      ],
    )
  ]
]

#speaker-note[
  - I picked this as a first example because it's _also_ a case of GitHub improving its defaults, but in an uneven way. This will be a recurring theme through the talk.
  - For one, _new_ repositories on GitHub no longer give the runner's `GITHUB_TOKEN` write access by default. But old repos still do, and established projects are older by definition!
  - For another, v6 and newer of the `checkout` action made it so that the credential is persisted in a temporary directory instead. This makes it harder to embed your token into an artifact. But plenty of projects still use `RUNNER_TEMP` for scratch space because GitHub documents it as such.
  - Finally, v4.4 and newer of `upload-artifact` skip hidden files and directories by default. But this doesn't protect users who bypass `upload-artifact` and use the artifact APIs directly, and it's also very disruptive to innocent workflows.
]

// = #emoji.face.think
//
// #speaker-note[
//   - So, if GitHub has already improved the defaults here, how could they take it to the next level?
//   - In other words, how could they make this pattern _fully_ secure by default?
// ]

== (insecure) platform defaults

#align(center + horizon)[
  #show raw: set text(size: 25pt)

  // Full pin (abbreviated below): c7d749a2d57b4b375d1ebcd17cfbfb60c676f18e
  ```yaml
  jobs:
    test:
      runs-on: ubuntu-latest
      steps:
        - name: checkout
          uses: actions/checkout@c7d749a2… # v7.0.0
        - run: make test
  ```
]

#speaker-note[
  - So, let's take a look at some other cases where the defaults haven't shifted as much, or really at all.
  - Here's another workflow you might see on any given day of the week.
  - It uses a hash-pin instead of a version pin, which ensures that we always get the exact same contents and not a mutable tag or branch reference.
  - Many online resources, including both zizmor and GitHub's official documentation, will tell you to use hash-pins for improved security.
]

== (insecure) platform defaults

#slide(config: config-common(subslide-preamble: none))[
  #align(center + horizon)[
    #show raw: set text(size: 21pt)
    #set par(leading: 0.5em)

    // Full pin (abbreviated below): c7d749a2d57b4b375d1ebcd17cfbfb60c676f18e
    ```
    error[impostor-commit]:
      commit with no history in referenced repository

     --> example-workflows/impostor.yml:8:15
      |
    7 |       - name: checkout
      |         -------------- this step
    8 |         uses: actions/checkout@c7d749a2… # v7.0.0
      |               ^^^^^^^^^^^^^^^^^^^^^^^^^^
      |               uses a commit that doesn't belong
      |               to the specified org/repo
      |
      = note: audit confidence → High
    ```
  ]
]

#speaker-note[
  - This is what zizmor shows for that workflow.
  - Unfortunately the workflow is completely owned: we thought we were pulling from a trusted source (`actions/checkout`), but actually we're pulling a commit from some random fork. Anybody in the world can make a public fork, so it's truly arbitrary code.
  - This is a consequence of GitHub's fork network design: GitHub uses Git alternates to share a single Git object database across a repo and its forks. As a result, most of GitHub's APIs don't "see" the difference between a fork and its parents when referencing Git objects by SHA instead of name.
  - I find this particularly terrifying because it's _so_ easy to miss: external contributors try to bump my actions all the time, and I'm one slip-up away from them having full code execution on a trusted trigger (like `push`).
]

== (insecure) platform defaults

#rounded-image("assets/impostor-banner.png", width: 100%)

#speaker-note(subslide: 1)[
  - GitHub is aware of this; it's an intentional design and performance tradeoff in their Git hosting model.
  - It's even something their web UI will warn you about, if you navigate to the commit directly. But that only shows up in the commit view, not anywhere in Actions itself. And there's no official API for checking impostor-ness, although there's an undocumented one if you look in the right place.
  - So, what could GitHub do better here, in terms of secure defaults?
]

#pause

#block(width: 100%, height: 1fr, above: 0.3em)[
  #align(center + horizon)[
    #rounded-image("assets/sha-policy.png", height: 100%)
  ]
]

#speaker-note(subslide: 2)[
  - Well, I think the answer is kind of self-evident: this just shouldn't work at all!
  - GitHub should simply refuse to run workflows that contain impostor commits. That includes transitive uses through composite actions.
  - The moving parts for this already exist within the platform: GitHub lets projects opt into requiring actions to be fully hash-pinned, and there's the undocumented API that I mentioned. They're just not tied together in a way that produces a secure default, yet.
]

== footguns

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: important step
        run: echo "It's really important to secure this"
        if: |
          ${{ github.event.name == 'push' }}
```

#speaker-note[
  - One last example before we move to the next domain.
  - Once again, we have a workflow we've all seen some version of.
  - In this case, we're trying to limit a step so that it only runs on a `push` event, even if its parent workflow supports other triggers. This is important if, say, another trigger for the workflow is extremely security sensitive, such as a `pull_request_target` or `workflow_run`.
]

== footguns

```
error[unsound-condition]: unsound conditional expression
  --> example-workflows/unsound-condition.yml:9:9
   |
 9 | /         if: |
10 | |           ${{ github.event.name == 'push' }}
   | |_____________________________________________^ condition always evaluates to true
   |
   = note: audit confidence → High
   = note: this finding has an auto-fix
```

#speaker-note[
  - As you've doubtless surmised, this workflow is vulnerable. This is what zizmor would show you for it.
  - The footgun here is that GitHub Actions expressions and YAML do not compose together cleanly.
  - In this case, we have a YAML multi-line string. GitHub then evaluates the expression to `false` but then embeds it within the string, resulting in the token `false` followed by a newline. And that's a string instead of a boolean, so it evaluates to `true` instead of `false`.
  - The end result is that we thought we were adding a defensive guard, but in reality GitHub Actions will happily run our step for an attacker.
]

== footguns

#block(width: 100%, height: 1fr)[
  #grid(
    columns: (1fr, 1.4fr),
    rows: (1fr,),
    column-gutter: 1em,
    align: (center + horizon, left + horizon),
    [
      #box(width: 100%, fill: rgb("#334155"), radius: 17pt, inset: 5pt)[
        #rounded-image("assets/drake.jpg", width: 100%)
      ]
    ],
    [
      #block(width: 100%, fill: rgb("#F5F5F5"), radius: 12pt, inset: 0.55em)[
        #show raw: set text(size: 22pt)
        ```
        ${{
          github.event.name == 'push'
            && ''
            || 'bar'
        }}
        ```
      ]
    ],
  )
]

#speaker-note[
  - That's a funny example because of how obviously wrong it is, but there are actually quite a few of these footguns in the Actions expression language.
  - For example, this ternary-style condition won't do what you expect. Most people would expect it to evaluate to the empty string, but it actually evaluates to `'bar'`.
  - GitHub added the `case()` function to work around this in January, but users need to manually identify currently buggy patterns and upgrade them manually.
]

== footguns

#block(width: 100%, height: 1fr)[
  #grid(
    columns: (1fr, 1.4fr),
    rows: (1fr,),
    column-gutter: 1em,
    align: (center + horizon, left + horizon),
    [
      #box(width: 100%, fill: rgb("#334155"), radius: 17pt, inset: 5pt)[
        #rounded-image("assets/drake.jpg", width: 100%)
      ]
    ],
    [
      #block(width: 100%, fill: rgb("#F5F5F5"), radius: 12pt, inset: 0.55em)[
        #show raw: set text(size: 22pt)
        ```yaml
        if: ${{
            contains(
              'refs/heads/main
               refs/heads/develop',
              github.ref
            )
          }}
        ```
      ]
    ],
  )
]

#speaker-note[
  - A third example: GitHub provides the `contains()` function for checking whether or an array or string contains some element.
  - But there's no native way to express an array in an actions expression: you need to create an array via `fromJSON`, which people forget to do.
  - They end up writing things like this instead, which _look_ right but are actually buggy. For example, a branch named `mai` would pass this check, since `mai` is a substring of the haystack. That's clearly not what the developer intended!
  - So, the common theme in these expression footguns is that there's a discontinuity between the user's intuitions around how the expression DSL _should_ behave and how it _actually_ behaves.
  - Also, just for the record, zizmor will detect all of these, and more.
]

= community practices

#speaker-note[
  - Okay, I think I've ragged on GitHub themselves enough, at least for now.
  - Let's talk about some ways in which the Actions community has also encouraged and even ossified insecure-by-default practices.
  - The distinction here is arguably more subtle than I can fairly relate in just one talk.
  - I think it could fairly be argued that GitHub shares some responsibility here, given that programmers tend to do easy things and being insecure is easier than being secure on GitHub Actions.
  - But it also takes two to tango, and many common third-party patterns within the Actions ecosystem warrant scrutiny.
]

== YOLO binaries

#v(-0.4em)

#align(center + top)[
  #show raw: set text(size: 20pt)
  #show raw.where(block: true): set block(above: 0.6em, below: 0pt)
  #set par(leading: 0.25em)

  #stack(
    spacing: 1.25em,
    block(width: 100%, fill: rgb("#F5F5F5"), radius: 12pt, inset: (x: 0.8em, y: 0.4em))[
      #set align(left)
      #text(size: 20pt, weight: "semibold", fill: rgb("#334155"))[what the user sees]

      ```yaml
      - uses: example/setup-gizmo@abcd... # v1.0.0
      ```
    ],
    block(width: 100%, fill: rgb("#F5F5F5"), radius: 12pt, inset: (x: 0.8em, y: 0.4em))[
      #set align(left)
      #text(size: 20pt, weight: "semibold", fill: rgb("#334155"))[what the action runs]

      ```yaml
      inputs:
        version:
          required: false
          default: "latest"

      # ...
      runs:
        steps:
          - run: "npm install gizmo@{{ inputs.version }}"
      ```
    ],
  )
]

#speaker-note[
  - One of the most common patterns I see in GitHub Actions is what I call the "YOLO binary" pattern.
  - This is where, even _if_ you do everything as a user, like hash-pinning the action itself, the action still exhibits interior mutability. That mutability effectively defeats much of the value of a hash-pin.
  - One of the most common ways this happens is by providing an action input that sets the tool's version, but then defaulting to "latest" when none is given.
  - "Latest" then gets pulled from the latest GitHub release or whatever, with no real hash-pinning since the action can't possibly know the hashes for newer binaries _a priori_.
  - The concerning thing about this pattern is that it's largely invisible and even taken for granted, unless you ready every single line of code for every action you depend on: it can happen deep inside the action's own rats' nest of shell scripts, Dockerfiles, or JavaScript.
]

== YOLO binaries

#slide(config: config-page(margin: (x: 2em, top: 1em, bottom: 2em)))[
  #v(-0.6em)

  #block(width: 100%, height: 1fr)[
    #align(center)[
      // Fill the slide area by cropping the image's blank top and bottom margins.
      #box(width: 100%, height: 100%, fill: rgb("#334155"), radius: 17pt, inset: 5pt)[
        #rounded-image("assets/frog-and-toad.png", width: 100%, height: 100%, fit: "cover")
      ]
    ]
  ]
]

#speaker-note[
  - I think it's worth asking ourselves: why does this happen?
  - There are a few reasons, but three big ones stand out to me.
  - First, we've promulgated the idea that there's something fundamentally _wrong_ with not using the latest version of every thing we use, ever. I don't think this has panned out well for open source; we've seen attackers take advantage of this trend to launch massive and effective supply chain attacks.
  - Second, the packaging ergonomics themselves encourage it: almost every packaging ecosystem makes it easier to install the floating "latest" version of a package rather than some specific version.
  - Finally, the lack of alternative ergonomics on the Actions side _reinforce_ it, or at least did for a very long time.
  - The latter has improved significantly in recent years with tools like Dependabot and Renovate, but GitHub Actions itself still doesn't behave like a normal packaging ecosystem in a lot of important ways, including update ergonomics!
]

== YOLO binaries

#slide(config: config-common(subslide-preamble: none))[
  #block(width: 100%, height: 1fr)[
    #grid(
      columns: (1fr,),
      rows: (auto, 1fr),
      row-gutter: 0.5em,
      align: center + horizon,
      [
        #layout(size => {
          let width = size.width * 75%
          // Keep the byline and title: the top 340px of the 1830px-wide screenshot.
          box(width: width, height: width * 340 / 1830, radius: 12pt, clip: true)[
            #place(top + left)[
              #image("assets/nesbitt1.png", width: width, height: width * 540 / 1830)
            ]
          ]
        })
      ],
      [#rounded-image("assets/nesbitt2.png", height: 100%)],
    )
  ]
]

#speaker-note[
  - At the end of the day, GitHub can never fully prevent a third-party action from exhibiting interior mutability.
  - It's all arbitrary code, after all. And like all open source you fundamentally need to trust it.
  - However, there are a few things that GitHub _could_ do to nudge their ecosystem away from this practice.
  - For example, GitHub could continue to make the practice of updating actions more ergonomic. If it's easier to update actions themselves, then actions can be more aggressive about interior pinning.
  - That's part of a larger observation, which is that GitHub Actions should behave more like the packaging ecosystem it functions as. Andrew Nesbitt has a great blog post from last December showing just how stark the feature divide between Actions and other packaging ecosystems is.
]

== YOLO binaries

```
help[adhoc-packages]: ad-hoc installation of packages
  --> example-workflows/adhoc-package.yml:11:11
   |
10 |         run: |
   |         --- this step
11 |           npm install prettier
   |           ^^^^^^^^^^^^^^^^^^^^ installs a package outside of a lockfile
   |
   = note: audit confidence → High
```
#speaker-note[
  - It would of course be remiss of me not to mention that zizmor will flag many of these YOLO binary patterns.
  - zizmor will also flag similar patterns on the workflow side, for example when you've used `npm install` or `pip install` to install a tool in an ad-hoc manner rather than putting it in a proper lockfile.
]

== javascript actions

```yaml
name: "some-cool-action"
description: "Deletes your kubernetes cluster"
inputs:
  github-token:
    description: The GitHub API token to use
    default: ${{ github.token }}
runs:
  using: node24
  main: dist/index.js
  post: dist/index.js
```

#speaker-note[
  - Now for a slightly spicier one.
  - If you've ever developed an action, you know that they come in approximately three forms: there are Docker actions, composite actions, and JavaScript actions.
  - All three forms share a common base, which is that they are defined within a GitHub repository or a directory thereof and use an `action.yml` file to declare metadata and their entrypoint.
  - However, JavaScript-based actions are...special.
  - A huge reason to use a language like JavaScript is that it grants you access to its packaging ecosystem. But GitHub Actions doesn't have a "bundle" concept, so how are all of those dependencies supposed to get onto the runner?
]

== javascript actions

#v(-0.4em)

#align(center + horizon)[
  #stack(
    spacing: 0.75em,
    rounded-image("assets/checkout.png", width: 100%),
    rounded-image("assets/large-js.png", width: 100%),
  )
]

#speaker-note[
  - The answer, of course, is just to check them directly into the repo. So just about every JavaScript-based action has a `dist/` directory containing an ungodly amount of minified JavaScript.
  - I think this is really bad on several levels.
  - For one, it's almost completely unauditable. In many cases, we have to just sort of hope that the bundled version of the action is the same as the readable version, despite both being checked into the repo.
  - For another, it treats the Git repository itself as the packaging and distribution substrate, despite GitHub having a separate and very mature platform for creating releases from tags.
  - This in turn means that important security features on the release side (like immutable releases and environment protections) don't inherently apply to actions; users need to do more work to do the secure thing.
]

== community practices

#speaker-note[
  - What could GitHub do to improve these community practices?
  - As I mentioned before, GitHub fundamentally can't stop people from doing whatever they want. After all, CI/CD is fundamentally arbitrary code execution.
  - As such we can't expect them to work miracles.
  - But what GitHub _could_ do is continue to invest in Actions not just as a platform, but as a packaging ecosystem.
  - My intuition is making the packaging experience smoother in Actions can and will nudge users away from doing risky and opaque things.
  - For YOLO packages, that probably means making action upgrades even more of a first-class exprience, rather than something that's layered on top of a repository via Dependabot.
  - For JavaScript actions, I think it means fundamentally re-evaluating how actions are distributed.
  - Webassembly has made huge strides as a runtime in recernt years, and I wonder if WASM could help with both distribution and security isolation.
]

= reliability and availability

#speaker-note[
  - Ok, now back to that elephant.
]

== reliability and availability

#speaker-note[
  - I think nobody in this room is unfamiliar with GitHub's recent reliability and availability issues.
  - Recent outages have affected almost every part of GitHub, including Actions.
]

== reliability and availability

== reliability and availability

= "actions v2"

= concluding thoughts

// github is doing a lot better, but there are still significant headwinds that must be overcome
//
// they're improving the defaults in actions, but in a spiky/uneven way
// specifically, not making the defaults better retroactively helps existing OSS projects the least
//
// outside of what github themselves can fix, the ecosystem as a whole needs to mature
// but github themselves can aide in that by nudging/incentivizing better behaviors
//
// finally, github's own availability/reliability problems are also a security concern,
// because they risk putting us back into a pre-github world where everything is "shifted right"
// back onto developer boxes.
//
// zizmor should not exist!

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
        #text(size: 2em, weight: "bold")[thank \ you!]
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
