# github-universe-2026

Slides and assets for a talk at GitHub Universe 2026.

## Building

Generate a PDF copy of the slides, including speaker notes:

```shell
make pdf
```

The presentation uses the light layouts from the GitHub Universe 2026
PowerPoint template. `universe-theme.typ` defines the template's page geometry,
typography, footer, title slide, section dividers, and developer code panels.
Code blocks scale to fit their available space without changing line breaks.
`universe-code.tmTheme` uses the light template's syntax colors.
Diagnostic blocks tagged `zizmor` use `zizmor.sublime-syntax` to reproduce
zizmor's ANSI emphasis: red errors, blue gutters and secondary annotations,
cyan help, and bold titles and note labels. The diagnostic palette is adapted
for the light background. Source excerpts remain plain, as in the CLI output.
Image slides use the template's Title and Image frame; text slides use Title
and Content. The title card includes the speaker portrait, and the introduction
uses Speaker bio with the existing project logos in its bio area.
Mixed image/code slides use Developer Code Right. The closing
slide retains the template's original background and adds the talk's QR links.
Untitled slides share the light Blank layout's content insets. Stacked images
fit at a common width while preserving their aspect ratios and a consistent gap.

Complete Mona Sans fonts from GitHub's official v2.0.27 release are included in
`fonts/mona-sans/`; its `README.txt` records the source and archive checksum.
The font families and weights follow the template, with upstream glyph and
spacing updates from the newer release. The template's original branding
graphics are in `assets/universe-template/`.
`make pdf` and `make watch` load the bundled fonts automatically; no system font
installation or PowerPoint/Keynote dependency is needed to build the slides.
