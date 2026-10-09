.PHONY: all
all:
	@echo Run my individual targets.

.PHONY: pdf
pdf: github-universe-2026.typ
	typst compile --font-path=fonts/ $<

.PHONY: watch
watch: github-universe-2026.typ
	typst watch --font-path=fonts/ $<
