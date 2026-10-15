Complete, unmodified static TTF files from GitHub's official Mona Sans release.

Release: v2.0.27
https://github.com/github/mona-sans/releases/tag/v2.0.27

Archive:
https://github.com/github/mona-sans/releases/download/v2.0.27/mona-sans-static-v2.0.27.zip
SHA-256 (verified against the release asset's published digest):
aa44edb86d4848f071ff0b36bbb79041eacf23f5b6ea9b2ff65463e35281b4c3

The TTF files are copied directly from fonts/static/ttf/ in that archive;
OFL.txt is copied from its root. All three families are version 2.027:
Mona Sans, Mona Sans Display, and Mona Sans Mono.
Regular and Italic have weight 400, Medium and MediumItalic 500, and Bold 700.

These files include the Latin macrons used in the talk. No fonts extracted
from PowerPoint are used in the build. Static faces keep weight selection
explicit, with only one version of each family bundled.

This release is newer than the template's embedded fonts. It retains the
same families and weights but includes upstream glyph and spacing changes,
particularly in Mono; it is not an exact copy of the template's font build.
The theme disables ligatures and contextual substitutions in code to preserve
literal operators; this release otherwise renders == as a single = glyph.

Upstream: https://github.com/github/mona-sans
License: SIL Open Font License 1.1; see OFL.txt.
