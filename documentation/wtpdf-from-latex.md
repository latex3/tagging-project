---
layout: "ngpdf"
lang: "en"
---

<script>
runlatex.editorlines=120;
</script>

# Generating Well Tagged PDF from LaTeX

### An Initial Example

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
% Using the \DocumentMetadata command results in a tagged and accessible PDF file.
% Use ‘pdfversion’ and ‘pdfstandard’ keys to select the output file type.
\DocumentMetadata{
  lang        = en,
  pdfversion  = 2.0,
  pdfstandard = ua-2,
  pdfstandard = a-4, % or a-4f
  testphase   = latest
}

% Remove this line to generate MathML Associated Files rather than Structure Elements
% The file would then need to declare PDF/A-4f rather than PDF/A-4 conformance.
\tagpdfsetup{math/mathml/structelem, math/mathml/AF=false, math/tex/AF=false, math/mathml/sources=}

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

The above small example shows the basic features of a Tagged LaTeX document.
Here we show a larger more complex two-column document including generated
cross references and citations. Some familiarity with LaTeX is assumed, and
we do not show this by default.



<details markdown="1">

<summary><h3 style="display:inline">A Larger Example</h3></summary>


<p> </p>

```latex
\DocumentMetadata{
  lang        = en,
  pdfversion  = 2.0,
  pdfstandard = ua-2,
  pdfstandard = a-4f,
  testphase   = latest
}

% Remove this line to generate MathML Associated Files rather than Structure Elements
% The file would then need to declare PDF/A-4f rather than PDF/A-4 conformance.
\tagpdfsetup{math/mathml/structelem, math/mathml/AF=false, math/tex/AF=false, math/mathml/sources=}

\documentclass[a4paper,twocolumn]{article}

\usepackage{unicode-math}
\usepackage{graphicx}

\begin{document}

\title{A Larger Example}
\date{2024-12-17}
\author{The \LaTeX\ Team}

\maketitle

\begin{abstract}
  An example document showing automatic tagging of typical structures
  found in a \LaTeX\ document, including titles, sections, lists,
  citations lists and mathematics. A two column layout is used, the
  tagging enables the reading order to correctly follow the flow of
  text through the columns.
\end{abstract}

\tableofcontents

\section{Introduction}

This document shows a typical two-column document incorporating tables, figures and mathematics.

Apart from two commands at the start to enable tagging, and a small
amount of additional markup to give alternative texts for graphics
inclusion, and to specify the heading rows of tables. The document
just uses standard \LaTeX\ markup that would be used in any \LaTeX\
document since the 1980's.

\section{Document structures}

\subsection{Mathematics}

Let $p$ be a prime, then
\[n^p=n \mod p\]

An aligned set of equations:
\begin{align}
  f(x)&=\sin x + \cos y \\
  g(x)&=2\cos x - 3\sin y
\end{align}

Matrices.
\[
\begin{pmatrix}1&2\\3&4\end{pmatrix}
\begin{pmatrix}1&1\\0&1\end{pmatrix}
=
\begin{pmatrix}1&3\\3&7\end{pmatrix}
\]

\subsection{Lists}
Lists often occur in documents
\begin{itemize}
\item They may be unordered bullet lists
\item Or may be numbered lists.
  \begin{enumerate}
  \item lists may also be nested in an outer list
  \item \label{item-a}items within such a list may be referenced.
  \end{enumerate}
\end{itemize}
Here we reference item~\ref{item-a}.

\subsection{Figures and Tables}

Small images may be shown inline
\includegraphics[height=1em,alt=small skull in a diamond]{ghsystem_skull.jpg}
and small tables may be shown within the paragraph:
\begin{center}
\tagpdfsetup{table/header-rows={1,2}}
\begin{tabular}{lr}
\multicolumn{2}{c}{Example}\\
Name&Value\\
This& 11 \\
That & 2
\end{tabular}
\end{center}

Larger figures are usually placed in a \emph{float} to be positioned at a suitable
place to help with column and page breaking.
\begin{figure}
  \centering
  \includegraphics[alt=example image A,width=.9\linewidth]{example-image-a}
  \caption{Larger image set as a \emph{float}}
\end{figure}

\subsection{Citations}
It is also possible to cite works from a bib\TeX\ database, here we
cite \cite{article-full} and \cite{inbook-full} from the
\texttt{xampl.bib} sample file distributed with bib\TeX.

\bibliographystyle{plain}
\bibliography{xampl}

\end{document}
```

</details>

----


<details markdown="1">

<summary><h3 style="display:inline">Notes on the Example Server</h3></summary>


The example is shown in an online editor embedded in the
page.

The <button>Generate tagged PDF</button> button will run (Lua)LaTeX
at texlive.net. Links will be generated to directly view the PDF or
to open the PDF at ngpdf.com which will allow the tagged structure to be
navigated and the derived HTML to be viewed.

[texlive.net help](https://davidcarlisle.github.io/latexcgi/)

[ngPDF help](https://ngpdf.com/help)

These examples run using the texlive.net and ngpdf.com services
provided by [DANTE](https://www.dante.de) and [Duallab](https://duallab.com) respectively.
Please do not over use the services, they are not set up to process heavy loads
but are intended just to run small examples in order to show how to use
LaTeX to generate tagged PDF.


</details>