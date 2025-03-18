---
layout: "ngpdf"
lang: "en"
---

<script>
runlatex.editorlines=120;
</script>

[Well Tagged PDF Video Examples](./)

# Generating Well-Tagged PDF from LaTeX

## A small demonstration file

This page allows you to create a demonstration PDF from LaTeX. To
generate Tagged PDF on your own system you’ll need a recent
distribution.

To enable standards-conforming Tagged PDF output, simply add at the
very beginning of the document, i.e., before `\documentclass`, a
`\DocumentMetadata` declaration. It takes one argument, a key-value
list.

The first four keys in the document metadata declaration below set
necessary document metadata, including language, PDF version and the
ISO-standardized subset of PDF to which the document should comply.

## Demonstration

Simply click the “Generate Tagged PDF” button below the following example code, or edit the example before generating a PDF.

Please keep your example relatively small to avoid overburdening the free service we’re providing here.

If you prefer a more realistic demonstration file, such as a complex
two-column document including a table of contents, mathematical
formulae and theorem, graphics, marginal notes, footnotes, a code
display, a bibliography, a generated cross reference and citations,
[that’s available](larger-example).


```latex
% Using the \DocumentMetadata command results in a tagged and accessible PDF file.
% Use ‘pdfversion’ and ‘pdfstandard’ keys to select the output file type.
\DocumentMetadata{
  lang        = en,
  pdfversion  = 2.0,  % or 1.7 if desired pdfstandard = ua-1
  pdfstandard = ua-2, % or ua-1 if pdfversion = 1.7
  pdfstandard = a-4,  % or a-4f (see below)
  testphase   = latest
}

% The next declaration results in a tagged PDF with MathML included via structure elements (tags).
% Remove this declaration to generate a tagged PDF with MathML Associated Files, as the use
% of this feature requires the PDF file to declare conformance with PDF/A-4f rather than PDF/A-4.
% LaTeX will automatically switch to declare PDF/A-4f if Associated Files are used when the
% document declares pdfstandard = a-4.
\tagpdfsetup{math/setup=mathml-SE}

\documentclass{article}
% Using Unicode math fonts improves the tagging of math.
\usepackage{unicode-math}

% Classic LaTeX document markup from here.
\begin{document}

\section{A small example}

Some inline mathematics involving $x\in\symbb{R}$.

A list of items
\begin{enumerate}
\item a first item;
\item a second item;
\item a third item.
\end{enumerate}

Display math
\[
c=\sqrt{a^2+b^2}
\]

\end{document}
```

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
