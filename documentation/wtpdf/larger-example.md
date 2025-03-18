---
layout: "ngpdf"
lang: "en"
---

<script>
runlatex.editorlines=120;
</script>


# Generating Well-Tagged PDF from LaTeX

## A realistic demonstration file

This page allows you to create a demonstration PDF from a complex
two-column LaTeX document including a table of contents, mathematical
formulae and theorem, graphics, marginal notes, footnotes, a code
display, a bibliography, a generated cross reference and citations.

To enable standards-conforming Tagged PDF output, simply add at the
very beginning of the document, i.e., before `\documentclass`, a
`\DocumentMetadata` declaration. It takes one argument, a key-value
list.