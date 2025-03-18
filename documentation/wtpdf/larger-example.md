---
layout: "ngpdf"
lang: "en"
kramdown:
    syntax_highlighter_opts:
      disable: true
---

<script>
function generatepreamble(t,e) {return e.getValue();}
runlatex.texts.metadata="";
runlatex.editorlines=120;
runlatex.preincludes = {
 "pre0": {"pre2": "t6.tex"},
 "pre1": {"pre2": "t6.tex"}
 }
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

The first four keys in the document metadata declaration below set
necessary document metadata, including language, PDF version and the
ISO-standardized subset of PDF to which the document should comply.

## Structure elements or Associated Files

LaTeX leverages two distinct options for including MathML in PDF documents that include math formulae.

 * Each formula can be represented by an embedded and so-called Associated File (AF) that contains its MathML representation, and / or
 * Each formula’s MathML representation is directly embedded into the PDF’s tags tree as structure elements.

Both are valid methods (as defined in ISO 32000-2, PDF’s
specification), but many reader software applications do not yet fully
support these features in PDF 2.0. We hope that more PDF software
producers will soon enable access to MathML in PDF files.

At present, the LuaTeX engine can automatically produce MathML tags
from LaTeX source and can support either method. pdfTeX only supports
the Associated Files method, with the data for the AF files prepared
in a separate step.

## Demonstration

Simply click the “Generate Tagged PDF” button below the following example code, or edit the example before generating a PDF.
Please keep your example relatively small to avoid overburdening the free service we’re providing here.
If you prefer a smaller demonstration file, that’s available.


### AF

```latex
{% include_relative t6-af.tex %}
```

### SE

```latex
{% include_relative t6-se.tex %}
```

### Document Text

```latex
%!TeX Use one of the above buttonsto generate Tagged PDF, suppress button here: none
{% include_relative t6.tex %}
```
{: .norun :}



## About the output

Your demonstration PDF will, by default, be generated via a standard TeXLive 2025 `lualatex-dev`.

As provided, the options used in the demonstration code will result in
MathML tags in the output PDF’s tag tree. If you remove the
configuration line indicated in the comments, LaTeX will instead
associate each math expression in the PDF with two embedded and
associated MathML files, one containing the TeX source, and one
containing the MathML equivalent.

The “Generate tagged PDF” button runs (Lua)LaTeX at
[texlive.net](https://texlive.net) (see [texlive.net help](https://davidcarlisle.github.io/latexcgi/)). Once the
PDF is generated links are provided allowing you to view or download
the resulting PDF, or open it at ngpdf.com (see [ngPDF help](https://ngpdf.com/help)), where the
Tagged PDF may be viewed together with an HTML representation derived
from the PDF using the MathML associated with each math formula.

These examples run using the texlive.net and ngpdf.com services
provided by [DANTE](https://www.dante.de) and
[Duallab](https://duallab.com) respectively. Please do not over use
the services, they are not set up to process heavy loads but are
intended just to run small examples in order to show how to use LaTeX
to generate tagged PDF. The submitted TeX source is deleted after the
PDF is generated. The generated PDF is deleted after one hour.

To generate Tagged PDF on your own system you’ll need a recent distribution.


## Full Document Videos

[fulldoc](fulldoc)
