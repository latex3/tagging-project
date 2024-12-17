---
layout: "ngpdf"
lang: "en"
---


# Generating Well Tagged PDF from LaTeX


To enable tagging in supported documents it is enough to add at the
very beginning of the document, i.e., before `\documentclass`, a
`\DocumentMetadata` declaration. It takes one argument, a key-value
list.

The first four keys in the example set important document metadata,
like the language, the requested PDF version and the standards the
document should comply with.

Tagging is then enabled by loading various modules through the
`testphase` key.

```latex
% Using the \DocumentMetadata key results in a tagged and accessible PDF file.
% Use ‘pdfversion’ and ‘pdfstandard’ options to select the output file type.
\DocumentMetadata{
  lang        = en,
  pdfversion  = 2.0,
  pdfstandard = ua-2,
  pdfstandard = a-4, % or a-4f
  testphase   = 
   {phase-III, title,table, math, firstaid}  
}

% Remove this line to generate MathML Associated Files rather than Structure Elements
% The file would then need to declare PDF/A-4f rather than PDF/A-4 conformance.
\tagpdfsetup{math/mathml/structelem, math/mathml/AF=false, math/tex/AF=false}

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
\begin{pmatrix}1&2\\3&4\end{pmatrix}
\begin{pmatrix}1&1\\0&1\end{pmatrix}
=
\begin{pmatrix}1&3\\3&7\end{pmatrix}
\]

\end{document}
```


----

You may directly run the example above, or edit it within this web
page, before generating the PDF.  Please keep the examples
relatively small.

The PDF will (by default) be generated via a standard TeXLive 2024
  lualatex-dev. The options used in the above example will tag every
  math expression with the TeX source of the expression, and with an
  automatically generated MathML version.  The resulting tagging, and
  the derived HTML (using the MathML associated with each math
  formula) may be viewed by following the link to the ngPDF site.


Initially the example will use a MathML Structure Element
tagging. If you remove the configuration line where indcated, then
LaTeX will instead associate each math expression with
two associated files, one with the TeX source, and one with generated MathML.


The submitted TeX source is deleted as soon as the PDF is
generated, and the resulting PDF is deleted after an hour.


----


<details>
<summary><h3 style="display:inline">Notes on the Example Server</h3></summary>
<p></p>

<p>The example is shown in an online editor embedded in the
page.</p>

<p>The <button>Generate tagged PDF</button> button will run (Lua)LaTeX
at texlive.net. Links will be generated to directly view the PDF or
to open the PDF at ngpdf.com which will allow the tagged structure to be
navigated and the derived HTML to be viewed.</p>

<p><a href="https://davidcarlisle.github.io/latexcgi/">texlive.net help</a></p>

<p><a href="https://ngpdf.com/help">ngPDF help</a></p>

<p>These examples run using the texlive.net and ngpdf.com services
provided by <a href="https:www.dante.de">DANTE</a> and <a href="https://duallab.com">Duallab</a> respectively.
Please do not over use the services, they are not set up to process heavy loads
but are intended just to run small examples in order to show how to use
LaTeX to generate tagged PDF.</p>

</details>