---
lang: en
layout: "ngpdf"
extrahead: youtube-head
---

<script>
runlatex.adddefaultpreamble=false;
runlatex.preincludes = {
 "pre1": {"pre0": "t3.tex"}
 "pre2": {"pre0": "t3.tex"}
 }
</script>

[Well Tagged PDF Video Examples](./)

----

# Full Document Sources

## LaTeX documment with no tagging.

```latex
% stub if not tagging
\providecommand\tagpdfsetup[1]{}

\documentclass[a4paper,twocolumn]{article}

\usepackage{unicode-math}
\usepackage{graphicx}
\usepackage[colorlinks]{hyperref}

\begin{document}

\title{A Two Column Example}
\date{2025-03-03}
\author{The \LaTeX\ Team}

\pagestyle{headings}

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
inclusion, and to specify the heading rows of tables%
\footnote{The current tagging markup for tables is temporary and a new interface
for tagging tables will be developed.}. The document
just uses standard \LaTeX\ markup that would be used in any \LaTeX\
document since the 1980's.

\section{Document structures}

\subsection{Mathematics}

Let $p$ be a prime, then
\[n^p=n \mod p\]

An aligned set of equations:
\begin{align}
  f(x)&=\sin x + \cos x  & f'(x) &=\cos x - \sin x \\
  g(x)&=2\cos x          & g'(x) &= -2\sin x 
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
cite \cite{Knuth:TB5-1-67} and \cite{Hoekwater:TB28-3-312} from the
\texttt{tugboat.bib} sample file distributed with bib\TeX.

\bibliographystyle{plain}
\raggedright
\bibliography{tugboat}

\end{document}
```

## Tagging, using Associated Files for Math

```latex
\DocumentMetadata{
  lang        = en,
  pdfversion  = 2.0,
  pdfstandard = ua-2,
  pdfstandard = a-4,
  testphase   = latest
}

\tagpdfsetup{
  math/setup=mathml-AF,
  root-supplemental-file=latex-align-css.html,
  root-supplemental-file=latex-list-css.html
  }


\input{t3}
```


## Tagging, using Associated Files for Math
```latex
\DocumentMetadata{
  lang        = en,
  pdfversion  = 2.0,
  pdfstandard = ua-2,
  pdfstandard = a-4,
  testphase   = latest
}

\tagpdfsetup{
  math/setup=mathml-AF,
  root-supplemental-file=latex-align-css.html,
  root-supplemental-file=latex-list-css.html
  }


\input{t3}
```
